import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class CustomOffersHome extends StatelessWidget {
  const CustomOffersHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            // Keep light shadow — only visible in light mode anyway.
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/Offers.jpg', fit: BoxFit.cover),
          ),
          // Intentionally dark overlay — must be dark in both modes for
          // readability of white text over the photograph.
          Container(color: Colors.black.withOpacity(0.5)),

          Padding(
            padding: EdgeInsets.all(15.r),
            child: Row(
              children: [
                Container(
                  width: 120.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      'إكتشف العروض',
                      // Always white — button sits on primary-color background.
                      style: AppTextStyles.font14SemiBoldWhite(context)
                          .copyWith(fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'عروض نهاية العام',
                        // Always white — text on dark photo overlay.
                        style: AppTextStyles.font20RegularWhite(context)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'استمتع بآخر لحظات الصيف بخصم بنسبة 15% على الأقل.',
                        style: AppTextStyles.font14SemiBoldWhite(context)
                            .copyWith(
                          fontSize: 13.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
