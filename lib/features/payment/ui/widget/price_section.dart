import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';
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
        _row(context, "المدة : $days أيام", subTotal),
        SizedBox(height: 12.h),
        _row(context, "ضرائب", taxes),
        SizedBox(height: 12.h),
        _row(context, "خدمات", services),
        SizedBox(height: 12.h),
        const Divider(),
        SizedBox(height: 12.h),
        _row(context, "الإجمالي", total, isTotal: true),
      ],
    );
  }

  Widget _row(BuildContext context, String title, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isTotal
              ? AppTextStyles.font20RegularPrimary(context).copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          )
              : AppTextStyles.font18RegularShadowPurple(context).copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          "${value.toInt()} EGP",
          style: AppTextStyles.font20BoldShadowPurple(context).copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}