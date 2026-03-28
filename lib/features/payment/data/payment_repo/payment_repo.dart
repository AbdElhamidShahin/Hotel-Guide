import 'package:dart_either/dart_either.dart';
import 'package:hotel_guide/features/payment/data/model/payment_intent_input_model.dart';

import '../../../../core/error/failure.dart';

abstract class PaymentRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
