import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/colors.dart';
import 'background_circles.dart';
import '../custom_textfeild_home.dart';

class BookingSearchForm extends StatelessWidget {
  const BookingSearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.primary,
        ),

        child: Stack(
          children: [
            BackgroundCircle(left: -60.r, bottom: -90.r),
            BackgroundCircle(right: -60.r, top: -90.r),

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
