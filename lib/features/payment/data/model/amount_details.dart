import 'tip_model.dart';

class AmountDetails {
  final Tip? tip;

  const AmountDetails({this.tip});

  factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
    tip: json['tip'] != null ? Tip.fromJson(json['tip']) : null,
  );

  Map<String, dynamic> toJson() => {
    if (tip != null) 'tip': tip!.toJson(),
  };
}