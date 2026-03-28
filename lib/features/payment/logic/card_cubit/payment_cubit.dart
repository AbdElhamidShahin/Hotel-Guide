import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/payment/data/payment_repo/payment_repo.dart';
import 'package:hotel_guide/features/payment/logic/card_cubit/payment_state.dart';
import '../../data/model/payment_intent_input_model.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;
  PaymentCubit(this.paymentRepo) : super(PaymentIninialState());
  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(PaymentLoadingState());
    var data = await paymentRepo.makePayment(
      paymentIntentInputModel: paymentIntentInputModel,
    );
    data.fold(
      ifLeft: (l) {
        emit(PaymentErrorState(l.errorMessage));
      },
      ifRight: (r) {
        emit(PaymentSuccessState());
      },
    );
  }

  @override
  void onChange(Change<PaymentState> change) {
    super.onChange(change);
  }
}
