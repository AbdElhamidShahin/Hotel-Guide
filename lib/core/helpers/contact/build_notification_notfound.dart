import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';

Widget BuildNotFoundNotification({VoidCallback? onRetry}) {
  return Builder(
    builder: (context) => Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/No Notification illustration.png',
              height: 250.h,
            ),
            SizedBox(height: 20.h),
            Text(
              'صفحة الإشعارات فارغة',
              style: AppTextStyles.font28BoldBlack(context),
            ),
            SizedBox(height: 32.h),
            Text(
              'في حال توفر أي إشعار ستظهرلك على الفور',
              textAlign: TextAlign.center,
              style: AppTextStyles.font16RegularMuted(context),
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
                  style: AppTextStyles.font18RegularShadowPurple(context)
                      .copyWith(color: AppColors.textWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
