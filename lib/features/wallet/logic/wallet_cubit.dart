import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/model/notification_model.dart';
import '../../../core/network/model/profile_model.dart';
import '../../../core/units/stripe_service.dart';
import '../../../features/payment/data/model/payment_intent_input_model.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final SupabaseClient _supabase;
  final StripeService _stripeService;

  WalletCubit({
    required SupabaseClient supabase,
    required StripeService stripeService,
  }) : _supabase = supabase,
       _stripeService = stripeService,
       super(WalletInitial());

  Future<void> fetchWalletData() async {
    emit(WalletLoading());
    try {
      final userId = _supabase.auth.currentUser!.id;

      final profileResponse = await _supabase
          .from(AppTableNames.profiles)
          .select()
          .eq('id', userId)
          .single();

      final userProfile = UserProfileModel.fromMap(profileResponse);

      final transactionsData = await _supabase
          .from(AppTableNames.walletTransactions)
          .select('*, bookings(hotel_name, check_in, check_out)')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      emit(
        WalletLoaded(
          userProfile,
          List<Map<String, dynamic>>.from(transactionsData),
        ),
      );
    } catch (e) {
      emit(WalletError('فشل في تحميل بيانات المحفظة'));
    }
  }

  Future<void> topUpWallet({required double amount}) async {
    final currentState = state;
    if (currentState is! WalletLoaded) return;

    emit(WalletTopUpLoading());

    try {
      final customerId = await _stripeService.getOrCreateStripeCustomerId(
        currentState.userProfile,
      );

      await _stripeService.makePayment(
        paymentIntentInputModel: PaymentIntentInputModel(
          amount: (amount * 100).toInt().toString(),
          currency: 'egp',
          customerId: customerId,
        ),
      );

      await _topUpInSupabase(
        userId: currentState.userProfile.id,
        amount: amount,
        hotelName: null,
      );

      final newBalance = currentState.userProfile.walletBalance + amount;
      emit(WalletTopUpSuccess(newBalance));

      await fetchWalletData();
    } catch (e) {
      emit(WalletTopUpError('فشل شحن الرصيد: ${e.toString()}'));
    }
  }

  Future<void> _topUpInSupabase({
    required String userId,
    required double amount,
    String? hotelName,
  }) async {
    try {
      await _supabase.rpc(
        AppRpcNames.topUpWallet,
        params: {'p_user_id': userId, 'p_amount': amount},
      );
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST202' || e.message.contains('does not exist')) {
        debugPrint('⚠️  top_up_wallet RPC not found — using manual fallback');
        await _topUpManual(userId: userId, amount: amount);
      } else {
        rethrow;
      }
    }
  }

  Future<void> _topUpManual({
    required String userId,
    required double amount,
  }) async {
    final profile = await _supabase
        .from(AppTableNames.profiles)
        .select('wallet_balance')
        .eq('id', userId)
        .single();
    final currentBalance = (profile['wallet_balance'] as num).toDouble();
    await _supabase
        .from(AppTableNames.profiles)
        .update({'wallet_balance': currentBalance + amount})
        .eq('id', userId);

    await _supabase.from(AppTableNames.walletTransactions).insert({
      'user_id': userId,
      'amount': amount,
      'transaction_type': 'topup',
      'status': 'completed',
      'description': 'شحن رصيد عبر البطاقة البنكية',
      'created_at': DateTime.now().toIso8601String(),
    });

    final notification = NotificationModel(
      title: 'تم شحن الرصيد ✅',
      body:
          'تمت إضافة ${amount.toStringAsFixed(2)} EGP إلى محفظتك بنجاح عبر البطاقة البنكية.',
      time: DateTime.now(),
      type: NotificationType.success,
    );
    await _supabase
        .from(AppTableNames.notifications)
        .insert(notification.toJson(userId));
  }
}
