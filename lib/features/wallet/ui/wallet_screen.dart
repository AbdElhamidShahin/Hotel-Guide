import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/wallet/ui/widget/custom_wallet_balance.dart';

import '../../../core/helpers/widget/custom_appbar_widget.dart';

class WalletScreen extends StatelessWidget {
   WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbarWidget(onTap: () {}, name: "المحفظة"),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomWalletBalance(

              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Text(
                  "اليوم",
                  style: textStyle16BoldWhite.copyWith(
                    color: AppColors.primary,
                  ),
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
                      _customRowItem(
                        'حجز',
                        ': نوع العملية',
                        'assets/icons/element-4.svg',
                        AppColors.primary,
                      ),
                      SizedBox(height: 18.h),

                      _customRowItem(
                        'Pyramids Gate Hotel',
                        ': اسم الفندق',
                        'assets/icons/Hotel.svg',
                        AppColors.RoyalPurple,
                      ),
                      SizedBox(height: 18.h),

                      _customRowItem(
                        '2026/3/19',
                        ': التاريخ',
                        'assets/icons/calendar-tick.svg',
                        AppColors.primary,
                      ),
                      SizedBox(height: 18.h),
                      _customRowItem(
                        '7800EGP',
                        ': المبلغ',
                        'assets/icons/dollar-circle.svg',
                        AppColors.primary,
                      ),
                      SizedBox(height: 18.h),
                      _customRowItem(
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
                  style: textStyle16BoldWhite.copyWith(
                    color: AppColors.primary,
                  ),
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
                      _customRowItem(
                        'استرداد',
                        ': نوع العملية',
                        'assets/icons/element-4.svg',
                        AppColors.primary,
                      ),
                      SizedBox(height: 18.h),

                      _customRowItem(
                        'Pyramids Gate Hotel',
                        ': اسم الفندق',
                        'assets/icons/Hotel.svg',
                        AppColors.RoyalPurple,
                      ),
                      SizedBox(height: 18.h),

                      _customRowItem(
                        '2026/3/15',
                        ': التاريخ',
                        'assets/icons/calendar-tick.svg',
                        AppColors.primary,
                      ),
                      SizedBox(height: 18.h),
                      _customRowItem(
                        '7800EGP',
                        ': المبلغ',
                        'assets/icons/dollar-circle.svg',
                        AppColors.primary,
                      ),
                      SizedBox(height: 18.h),
                      _customRowItem(
                        'قيد المعالجة',
                        ': الحالة',
                        'assets/icons/tick-circle.svg',
                        AppColors.AccentsOrange,
                      ),
                    ],
                  ),
                ),
              ),

          SizedBox(height:60.h,)  ],
          ),
        ),
      ),
    );
  }
}

Row _customRowItem(String title, String supTitle, String image, Color color) {
  return Row(
    children: [
      Text(title, style: textStyle16RegularGray.copyWith(color: color)),
      Spacer(),
      Text(
        supTitle,
        style: textStyle16RegularGray.copyWith(color: AppColors.primary),
      ),
      SizedBox(width: 8.w),
      SvgPicture.asset(image),
    ],
  );
}
