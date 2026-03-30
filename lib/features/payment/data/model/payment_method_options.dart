import 'card_model.dart';
import 'link_model.dart';

class PaymentMethodOptions {
  final CardOptions? card;
  final LinkOptions? link;

  const PaymentMethodOptions({this.card, this.link});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      PaymentMethodOptions(
        card: json['card'] != null ? CardOptions.fromJson(json['card']) : null,
        link: json['link'] != null ? LinkOptions.fromJson(json['link']) : null,
      );

  Map<String, dynamic> toJson() => {
        if (card != null) 'card': card!.toJson(),
        if (link != null) 'link': link!.toJson(),
      };
}
