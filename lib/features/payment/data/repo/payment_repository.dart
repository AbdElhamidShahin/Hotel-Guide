import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../model/payment_intent_input_model.dart';

/// Handles payment gateway operations only.
/// Separated from [BookingRepository] to respect the Single Responsibility
/// Principle — payment processing and booking persistence are distinct concerns.
abstract class PaymentRepository {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel input,
  });
}