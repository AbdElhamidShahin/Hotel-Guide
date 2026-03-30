import 'package:dartz/dartz.dart';
import 'package:hotel_guide/features/payment/data/repo/payment_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/units/stripe_service.dart';
import '../model/payment_intent_input_model.dart';

/// Concrete implementation of [PaymentRepository].
/// [StripeService] is injected — no `new StripeService()` here,
/// keeping this class testable and decoupled from the SDK.
class PaymentRepoImpl implements PaymentRepository {
  final StripeService _stripeService;

  const PaymentRepoImpl(this._stripeService);

  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel input,
  }) async {
    try {
      await _stripeService.makePayment(paymentIntentInputModel: input);
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
