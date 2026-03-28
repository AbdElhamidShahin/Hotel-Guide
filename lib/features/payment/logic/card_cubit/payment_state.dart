abstract class PaymentState {}

class PaymentIninialState extends PaymentState {}

class PaymentLoadingState extends PaymentState {}

class PaymentSuccessState extends PaymentState {}

class PaymentErrorState extends PaymentState {
  final String error;
  PaymentErrorState(this.error);
}
