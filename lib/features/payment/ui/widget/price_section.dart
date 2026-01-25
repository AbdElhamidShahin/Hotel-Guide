import 'package:flutter/material.dart';

class PriceSection extends StatelessWidget {
  final int days;
  final double subTotal;
  final double taxes;
  final double services;
  final double total;

  const PriceSection({
    super.key,
    required this.days,
    required this.subTotal,
    required this.taxes,
    required this.services,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row("المدة : $days أيام", subTotal),
        _row("ضرائب", taxes),
        _row("خدمات", services),
        const Divider(),
        _row("الإجمالي", total, isTotal: true),
      ],
    );
  }

  Widget _row(String title, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            )),
        Text("${value.toInt()} EGP",
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
