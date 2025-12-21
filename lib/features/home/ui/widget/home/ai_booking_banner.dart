import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class AiBookingBanner extends StatelessWidget {
  const AiBookingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.r),
        child: SizedBox(
          height: 97.h,
          width: double.infinity,
          child: Stack(
            children: [
              Image.asset(
                "assets/images/backGroundImageHome.jpg",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.4),
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
                      "assets/images/clickOn.png",
                      width: 65.w,
                      height: 55.h,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/iconCahtRobot.png",
                                width: 40.w,
                                height: 40.h,
                                color: AppColors.white,
                              ),
                              Text(
                                "  أحجز فندقك خلال ثواني",
                                style: textStyle16BoldWhite.copyWith(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Text(
                          "خلي الذكاء الإصطناعي يساعدك في عملية البحث",
                          style: textStyle14RegularNightfall.copyWith(
                            color: AppColors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
