import 'package:dart_either/dart_either.dart';
import 'package:dart_either/src/dart_either.dart';
import 'package:hotel_guide/core/error/failure.dart';
import 'package:hotel_guide/core/units/stripe_service.dart';
import 'package:hotel_guide/features/payment/data/model/payment_intent_input_model.dart';
import 'package:hotel_guide/features/payment/data/payment_repo/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      await stripeService.makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );
      return Right(null);
    } catch (e) {
      return Left(serverFailure(errorMessage: e.toString()));
    }
  }
}
