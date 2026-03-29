
import '../date/wallet_entity.dart';

/// The contract for all wallet data operations.
///
/// The Cubit and UseCases depend on THIS, never on WalletCubit's old
/// hardcoded `Supabase.instance.client`.
abstract class IWalletRepository {
  /// Fetches the wallet profile and all transactions for the authenticated user.
  Future<WalletEntity> fetchWalletProfile(String userId);

  /// Fetches all transactions for [userId], ordered by most recent first.
  Future<List<TransactionEntity>> fetchTransactions(String userId);
}

/// Typed domain exception for wallet operations.
class WalletException implements Exception {
  final String message;
  const WalletException(this.message);

  @override
  String toString() => 'WalletException: $message';
}
