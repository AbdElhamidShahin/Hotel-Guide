import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                'assets/images/onBoardingImage.jpg',
                width: 100.w,
                height: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pyramids Gate Hotel",
                    style: textStyle16mediumWhite.copyWith(
                      color: AppColors.black7,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_sharp,
                        size: 18.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "19 مارس 2026",
                        style: textStyle14RegularNightfall.copyWith(
                          color: AppColors.gray2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  RichText(
                    text: TextSpan(
                      style: textStyle16BoldWhite.copyWith(
                        color: AppColors.primary,
                      ),
                      children: [
                        const TextSpan(text: "يبدأ من "),
                        TextSpan(
                          text: "1000EGP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        const TextSpan(text: " / الليلة"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. سهم الانتقال
            Icon(Icons.arrow_forward_ios, size: 28.sp, color: AppColors.black7),
          ],
        ),
      ),
    );
  }
}
