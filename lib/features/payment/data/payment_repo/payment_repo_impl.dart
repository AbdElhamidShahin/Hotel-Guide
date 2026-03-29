import 'package:dart_either/dart_either.dart';
import 'package:hotel_guide/core/error/failure.dart';
import 'package:hotel_guide/features/payment/data/payment_repo/payment_repo.dart';
import '../../../../core/units/stripe_service.dart';
import '../model/payment_intent_input_model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final StripeService _stripeService;

  PaymentRepositoryImpl(this._stripeService);

  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel input,
  }) async {
    try {
      await _stripeService.makePayment(paymentIntentInputModel: input);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
