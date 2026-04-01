class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String? paymentMethodId;

  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
    this.paymentMethodId,
  });
  toJson() {
    return {
      'amount': '${amount}',
      'currency': currency,
      if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
    };
  }
}
