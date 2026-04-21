import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';

Widget BuildNotFoundSearch({VoidCallback? onRetry}) {
  return Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Not_Found.png', height: 250.h),
          SizedBox(height: 20.h),
          Text('نتيجة البحث غير موجودة', style: font28BoldBlack),
          SizedBox(height: 16.h),
          Text(
            'برجاء البحث مرة أخرى للعثور على النتائج\nالمناسبة',
            textAlign: TextAlign.center,
            style: font17RegularPrimary.copyWith(color: Color(0xFF9E9E9E)),
          ),
        ],
      ),
    ),
  );
}
