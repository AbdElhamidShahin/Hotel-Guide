import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors.dart';
import 'background_circles.dart';
import 'custom_textfeild_home.dart';

class BookingSearchForm extends StatelessWidget {
  const BookingSearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.primary,
        ),

        child: Stack(
          children: [
            BackgroundCircle(left: -55.w, bottom: -100.h),
            BackgroundCircle(right: -55.w, bottom: -100.h),
            BackgroundCircle(right: -55.w, top: -100.h),
            BackgroundCircle(left: -55.w, top: -100.h),

            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  CustomTextfeildHome(
                    width: 24.w,
                    height: 24.h,
                    title: 'الفندق',
                    text: 'إختر وجهتك',
                    image: "assets/icons/search-normal.svg",
                  ),

                  SizedBox(height: 24.h),
                  CustomTextfeildHome(
                    width: 40.w,
                    height: 40.h,
                    image: "assets/icons/حذف التاريخ.svg",
                    title: 'من',
                    text: '2025/3/15',
                  ),

                  SizedBox(height: 24.h),
                  CustomTextfeildHome(
                    width: 40.w,
                    height: 40.h,
                    image: "assets/icons/حذف التاريخ.svg",
                    title: 'الي',
                    text: '2025/3/18',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
