abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final double balance;
  final List<Map<String, dynamic>> transactions;
  WalletLoaded(this.balance, this.transactions);
}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}
