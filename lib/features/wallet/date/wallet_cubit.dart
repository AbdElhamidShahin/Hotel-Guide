import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/wallet/date/wallet_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletCubit extends Cubit<WalletState> {
  final SupabaseClient _client = Supabase.instance.client;
  WalletCubit() : super(WalletInitial());

  Future<void> fetchWalletData() async {print("🔄 [WalletCubit] Fetching updated balance and transactions...");
    emit(WalletLoading());
    try {
      final userId = _client.auth.currentUser!.id;

      // 1. جلب الرصيد من جدول profiles
      final profileData = await _client
          .from('profiles')
          .select('wallet_balance')
          .eq('id', userId)
          .single();

      // 2. جلب العمليات من جدول wallet_transactions
      final transactionsData = await _client
          .from('wallet_transactions')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      print("💰 [WalletCubit] New Balance: ${profileData['wallet_balance']}");
      print("📜 [WalletCubit] Transactions Count: ${transactionsData.length}");
      emit(WalletLoaded(
        (profileData['wallet_balance'] as num).toDouble(),
        List<Map<String, dynamic>>.from(transactionsData),
      ));
    } catch (e) {print("🛑 [WalletCubit] Fetch Error: $e");
      emit(WalletError("فشل في تحميل بيانات المحفظة"));
    }
  }
}