import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/model/profile_model.dart';

class WalletDataBundle {
  final UserProfileModel profile;
  final List<Map<String, dynamic>> payments;
  final List<Map<String, dynamic>> topUps;

  WalletDataBundle({
    required this.profile,
    required this.payments,
    required this.topUps,
  });
}

abstract class WalletRepository {
  Future<Either<Failure, WalletDataBundle>> getWalletDetails();
  Future<Either<Failure, void>> topUpBalance(double amount);
}
