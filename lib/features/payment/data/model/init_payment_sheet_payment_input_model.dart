class InitPaymentSheetInputModel {
  final String clientSecret;
  final String ephermeralKeysSecret;
  final String customerId;

  InitPaymentSheetInputModel({
    required this.clientSecret,
    required this.ephermeralKeysSecret,
    required this.customerId,
  });
}
