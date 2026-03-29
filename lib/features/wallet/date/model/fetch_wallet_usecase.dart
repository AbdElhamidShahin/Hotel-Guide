import '../../logic/i_wallet_repository.dart';
import '../wallet_entity.dart';

/// Fetches wallet profile and transactions for the given user.
///
/// The Cubit calls this — it has zero knowledge of Supabase.
class FetchWalletUseCase {
  final IWalletRepository _repository;

  const FetchWalletUseCase(this._repository);

  Future<({WalletEntity wallet, List<TransactionEntity> transactions})> call(
    String userId,
  ) async {
    if (userId.isEmpty) {
      throw const WalletException('المستخدم غير مسجل الدخول.');
    }

    final wallet = await _repository.fetchWalletProfile(userId);
    final transactions = await _repository.fetchTransactions(userId);

    return (wallet: wallet, transactions: transactions);
  }
}
