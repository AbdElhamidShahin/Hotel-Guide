import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../../../core/router/routers.dart';

class AiBookingBanner extends StatelessWidget {
  const AiBookingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(routes.ChatScreen),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: SizedBox(
            height: 110.h,
            width: double.infinity,
            child: Stack(
              children: [
                Image.asset(
                  'assets/Onpording/OnPoarding1.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Brand-color gradient overlay — intentionally the same in
                // both themes. It sits on a photo and creates the dark-to-light
                // fade that makes the text readable.
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.5),
                      ],
                      stops: const [0.22, 1.0],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/clickOn.png',
                        width: 50.r,
                        height: 50.r,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/iconCahtRobot.png',
                                  width: 25.r,
                                  height: 25.r,
                                  // Always white — on the primary-color overlay.
                                  color: AppColors.textWhite,
                                ),
                                Text(
                                  '  أحجز فندقك خلال ثواني',
                                  // Always white — text on dark gradient overlay.
                                  style: AppTextStyles.font16BoldWhite(context)
                                      .copyWith(fontSize: 20.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'خلي الذكاء الإصطناعي يساعدك في عملية البحث',
                              style: AppTextStyles.font14RegularNightfall(context)
                                  .copyWith(
                                color: AppColors.textWhite.withOpacity(0.7),
                                fontSize: 13.sp,
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
          ),
        ),
      ),
    );
  }
}
