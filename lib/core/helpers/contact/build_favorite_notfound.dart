import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

Widget buildFavoriteNotFoundWidget({VoidCallback? onRetry}) {
  return Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/NotFound_Favorite.png', height: 250.h),
          SizedBox(height: 20.h),
          Text(
            'صفحة المفضلة فارغة',
            style: textStyle28BoldWhite.copyWith(color: Colors.black),
          ),
          SizedBox(height: 32.h),
          Text(
            'في حال إضافة أي عنصر سيظهر هنا على\nالفور',
            textAlign: TextAlign.center,
            style: textStyle1Regularprimary.copyWith(color: Color(0xFF9E9E9E)),
          ),
          SizedBox(height: 40.h),
          SizedBox(
            width: 250.w,
            height: 70.h,
            child: ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.LightRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                elevation: 0,
              ),
              child: Text(
                'العودة للرئيسية',
                style: textStyle18RegularShadowPurple.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
