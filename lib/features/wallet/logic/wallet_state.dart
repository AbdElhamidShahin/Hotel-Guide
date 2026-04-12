import '../../../core/network/model/profile_model.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final UserProfileModel userProfile;
  final List<Map<String, dynamic>> paymentTransactions;
  final List<Map<String, dynamic>> topUpTransactions;

  WalletLoaded({
    required this.userProfile,
    required this.paymentTransactions,
    required this.topUpTransactions,
  });
}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}

class WalletTopUpLoading extends WalletState {}

class WalletTopUpSuccess extends WalletState {
  final double newBalance;
  WalletTopUpSuccess(this.newBalance);
}

class WalletTopUpError extends WalletState {
  final String message;
  WalletTopUpError(this.message);
}