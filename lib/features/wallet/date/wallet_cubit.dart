import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/wallet/date/wallet_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/model/profile_model.dart';

class WalletCubit extends Cubit<WalletState> {
  final SupabaseClient _client = Supabase.instance.client;
  WalletCubit() : super(WalletInitial());

  Future<void> fetchWalletData() async {
    emit(WalletLoading());
    try {
      final userId = _client.auth.currentUser!.id;

      final profileResponse = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      final userProfile = UserProfileModel.fromMap(profileResponse);

      final transactionsData = await _client
          .from('wallet_transactions')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      emit(WalletLoaded(
        userProfile,
        List<Map<String, dynamic>>.from(transactionsData),
      ));
    } catch (e) {
      emit(WalletError("فشل في تحميل بيانات المحفظة"));
    }
  }
}