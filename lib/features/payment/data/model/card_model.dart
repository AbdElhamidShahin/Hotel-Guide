class CardOptions {
  final String? requestThreeDSecure;

  const CardOptions({this.requestThreeDSecure});

  factory CardOptions.fromJson(Map<String, dynamic> json) => CardOptions(
    requestThreeDSecure: json['request_three_d_secure'],
  );

  Map<String, dynamic> toJson() => {
    'installments': null,
    'mandate_options': null,
    'network': null,
    'request_three_d_secure': requestThreeDSecure,
  };
}