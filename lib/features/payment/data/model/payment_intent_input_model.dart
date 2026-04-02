class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String? customerId;

  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
    this.customerId,
  });

  Map<String, dynamic> toJson() => {
    'amount': '${amount}',
    'currency': currency,
    'customer': customerId,
  };
}
