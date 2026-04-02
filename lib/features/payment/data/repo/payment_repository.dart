import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../model/payment_intent_input_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel input,
  });

}