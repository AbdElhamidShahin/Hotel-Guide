import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';

class CustomRefundHistory extends StatelessWidget {
  const CustomRefundHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.w, top: 50.h, bottom: 6.h),
          child: Text(
            'اليوم',
            style: AppTextStyles.font16BoldWhite(context).copyWith(
              color: isDark ? Colors.white : AppColors.primary,
            ),
          ),
        ),
        SizedBox(height: 50.h),
        Center(
          child: Text(
            'لا يوجد عمليات استرداد ',
            style: AppTextStyles.font36BoldWhite(context).copyWith(
              color: isDark ? Colors.white60 : AppColors.primary,
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}