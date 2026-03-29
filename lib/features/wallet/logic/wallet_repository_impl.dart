import 'package:supabase_flutter/supabase_flutter.dart';

import '../date/model/wallet_model.dart';
import '../date/wallet_entity.dart';
import 'i_wallet_repository.dart';



/// Concrete Supabase implementation of [IWalletRepository].
///
/// ✅ SupabaseClient is INJECTED — no more `Supabase.instance.client` hardcoded
///    as a field in WalletCubit.
/// ✅ Raw `Map<String, dynamic>` from Supabase never leaks into the Domain or
///    Presentation layers — WalletModel acts as the translation boundary.
class WalletRepositoryImpl implements IWalletRepository {
  final SupabaseClient _supabase;

  const WalletRepositoryImpl(this._supabase);

  @override
  Future<WalletEntity> fetchWalletProfile(String userId) async {
    try {
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return WalletModel.fromMap(data).toEntity();
    } on PostgrestException catch (e) {
      throw WalletException(
        e.message.isNotEmpty ? e.message : 'فشل تحميل بيانات المحفظة.',
      );
    } catch (e) {
      throw const WalletException('فشل تحميل بيانات المحفظة.');
    }
  }

  @override
  Future<List<TransactionEntity>> fetchTransactions(String userId) async {
    try {
      final data = await _supabase
          .from('wallet_transactions')
          .select('*, bookings(hotel_name, start_date)')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (data as List)
          .map((row) => TransactionModel.fromMap(row as Map<String, dynamic>))
          .map((model) => model.toEntity())
          .toList();
    } on PostgrestException catch (e) {
      throw WalletException(
        e.message.isNotEmpty ? e.message : 'فشل تحميل سجل المعاملات.',
      );
    } catch (e) {
      throw const WalletException('فشل تحميل سجل المعاملات.');
    }
  }
}
