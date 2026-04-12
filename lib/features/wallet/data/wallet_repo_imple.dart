import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/model/notification_model.dart';
import '../../../core/error/failure.dart';
import '../../../core/network/model/profile_model.dart';
import 'wallet_repo.dart';

class WalletRepositoryImpl implements WalletRepository {
  final SupabaseClient _supabase;
  const WalletRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, WalletDataBundle>> getWalletDetails() async {
    try {
      final userId = _supabase.auth.currentUser!.id;

      final results = await Future.wait([
        _supabase
            .from(AppTableNames.profiles)
            .select()
            .eq('id', userId)
            .single(),
        _supabase
            .from(AppTableNames.walletTransactions)
            .select()
            .eq('user_id', userId)
            .eq('type', 'payment')
            .order('created_at'),
        _supabase
            .from(AppTableNames.walletTransactions)
            .select()
            .eq('user_id', userId)
            .eq('type', 'top_up')
            .order('created_at'),
      ]);

      return Right(
        WalletDataBundle(
          profile: UserProfileModel.fromMap(results[0] as Map<String, dynamic>),
          payments: List<Map<String, dynamic>>.from(results[1] as List),
          topUps: List<Map<String, dynamic>>.from(results[2] as List),
        ),
      );
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> topUpBalance(double amount) async {
    try {
      final userId = _supabase.auth.currentUser!.id;

      try {
        await _supabase.rpc(
          AppRpcNames.topUpWallet,
          params: {'p_user_id': userId, 'p_amount': amount},
        );
      } catch (e) {
        await _performManualTopUp(userId, amount);
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _performManualTopUp(String userId, double amount) async {
    final data = await _supabase
        .from(AppTableNames.profiles)
        .select('wallet_balance')
        .eq('id', userId)
        .single();
    final currentBalance = (data['wallet_balance'] as num).toDouble();

    await _supabase
        .from(AppTableNames.profiles)
        .update({'wallet_balance': currentBalance + amount})
        .eq('id', userId);

    await _supabase.from(AppTableNames.walletTransactions).insert({
      'user_id': userId,
      'amount': amount,
      'type': 'top_up',
      'status': 'completed',
      'description': 'شحن رصيد يدوي',
      'created_at': DateTime.now().toIso8601String(),
    });

    await _sendNotification(userId, amount);
  }

  Future<void> _sendNotification(String userId, double amount) async {
    await _supabase
        .from(AppTableNames.notifications)
        .insert(
          NotificationModel(
            title: 'تم شحن الرصيد ✅',
            body: 'تمت إضافة ${amount.toStringAsFixed(2)} EGP إلى محفظتك.',
            time: DateTime.now(),
            type: NotificationType.success,
          ).toJson(userId),
        );
  }
}
