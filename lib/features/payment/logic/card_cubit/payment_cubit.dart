import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/payment/logic/card_cubit/payment_state.dart';

import '../../data/model/payment_intent_input_model.dart';
import '../../data/payment_repo/payment_repo.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository _paymentRepo;
  PaymentCubit(this._paymentRepo) : super(PaymentInitialState());

  Future<void> makePayment({required PaymentIntentInputModel input}) async {
    emit(PaymentLoadingState());
    final result = await _paymentRepo.makePayment(input: input);
    result.fold(
          (failure) => emit(PaymentErrorState(failure.message)),
          (_) => emit(PaymentSuccessState()),
    );
  }
}