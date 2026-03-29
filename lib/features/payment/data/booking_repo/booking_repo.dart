import 'package:dart_either/dart_either.dart';
import 'package:hotel_guide/core/error/failure.dart';
import '../../../../core/network/model/booking_model.dart';

abstract class BookingRepository {
  Future<Either<Failure, void>> confirmWithWallet(BookingEntity booking);
  Future<Either<Failure, String>> createStripePaymentIntent(double amount);
  Future<Either<Failure, void>> confirmWithStripe(BookingEntity booking);
  Future<Either<Failure, double>> getWalletBalance(String userId);
}