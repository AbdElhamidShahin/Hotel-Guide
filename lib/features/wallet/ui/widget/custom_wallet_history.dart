import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import 'custom_detail_row.dart';

class CustomWalletHistory extends StatelessWidget {
  const CustomWalletHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.w, top: 50.h, bottom: 6.h),
          child: Text(
            "اليوم",
            style: textStyle16BoldWhite.copyWith(color: AppColors.primary),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.ShadowPurple.withOpacity(.2),
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                CustomDetailRow(
                  'حجز',
                  ': نوع العملية',
                  'assets/icons/element-4.svg',
                  AppColors.primary,
                ),
                SizedBox(height: 18.h),

                CustomDetailRow(
                  'Pyramids Gate Hotel',
                  ': اسم الفندق',
                  'assets/icons/Hotel.svg',
                  AppColors.RoyalPurple,
                ),
                SizedBox(height: 18.h),

                CustomDetailRow(
                  '2026/3/19',
                  ': التاريخ',
                  'assets/icons/calendar-tick.svg',
                  AppColors.primary,
                ),
                SizedBox(height: 18.h),
                CustomDetailRow(
                  '7800EGP',
                  ': المبلغ',
                  'assets/icons/dollar-circle.svg',
                  AppColors.primary,
                ),
                SizedBox(height: 18.h),
                CustomDetailRow(
                  'مكتملة',
                  ': الحالة',
                  'assets/icons/tick-circle.svg',
                  AppColors.Green,
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(
            "الأمس",
            style: textStyle16BoldWhite.copyWith(color: AppColors.primary),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.ShadowPurple.withOpacity(.2),
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                CustomDetailRow(
                  'استرداد',
                  ': نوع العملية',
                  'assets/icons/element-4.svg',
                  AppColors.primary,
                ),
                SizedBox(height: 18.h),

                CustomDetailRow(
                  'Pyramids Gate Hotel',
                  ': اسم الفندق',
                  'assets/icons/Hotel.svg',
                  AppColors.RoyalPurple,
                ),
                SizedBox(height: 18.h),

                CustomDetailRow(
                  '2026/3/15',
                  ': التاريخ',
                  'assets/icons/calendar-tick.svg',
                  AppColors.primary,
                ),
                SizedBox(height: 18.h),
                CustomDetailRow(
                  '7800EGP',
                  ': المبلغ',
                  'assets/icons/dollar-circle.svg',
                  AppColors.primary,
                ),
                SizedBox(height: 18.h),
                CustomDetailRow(
                  'قيد المعالجة',
                  ': الحالة',
                  'assets/icons/tick-circle.svg',
                  AppColors.AccentsOrange,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
