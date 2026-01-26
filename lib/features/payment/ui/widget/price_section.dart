import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

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
        SizedBox(height: 12.h),
        _row("ضرائب", taxes),
        SizedBox(height: 12.h),

        _row("خدمات", services),
        SizedBox(height: 12.h),

        const Divider(),
        SizedBox(height: 12.h),

        _row("الإجمالي", total, isTotal: true),
      ],
    );
  }

  Widget _row(String title, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isTotal
              ? textStyle20RegularPrimary.copyWith(
                  color: AppColors.black6,
                  fontWeight: FontWeight.w600,
                )
              : textStyle18RegularShadowPurple.copyWith(
                  color: AppColors.Grayscale,
                ),
        ),
        Text(
          "${value.toInt()} EGP",
          style: textStyle20BoldShadowPurple.copyWith(color: AppColors.black6),
        ),
      ],
    );
  }
}
