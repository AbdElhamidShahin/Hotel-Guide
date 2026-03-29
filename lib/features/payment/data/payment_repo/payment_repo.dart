import 'package:dart_either/dart_either.dart';
import 'package:hotel_guide/core/error/failure.dart';
import '../model/payment_intent_input_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel input,
  });
}