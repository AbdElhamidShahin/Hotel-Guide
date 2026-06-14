import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';

Widget BuildNotFoundSearch({VoidCallback? onRetry}) {
  return Builder(
    builder: (context) => Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Not_Found.png', height: 250.h),
            SizedBox(height: 20.h),
            Text(
              'نتيجة البحث غير موجودة',
              style: AppTextStyles.font28BoldBlack(context),
            ),
            SizedBox(height: 16.h),
            Text(
              'برجاء البحث مرة أخرى للعثور على النتائج\nالمناسبة',
              textAlign: TextAlign.center,
              style: AppTextStyles.font16RegularMuted(context),
            ),
          ],
        ),
      ),
    ),
  );
}
