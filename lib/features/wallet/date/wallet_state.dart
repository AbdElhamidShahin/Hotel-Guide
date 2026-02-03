import '../../../core/network/model/profile_model.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final UserProfileModel userProfile;
  final List<Map<String, dynamic>> transactions;

  WalletLoaded(this.userProfile, this.transactions);
}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}
