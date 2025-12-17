import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../../core/router/routers.dart';

class CustomAppbarHome extends StatelessWidget {
  const CustomAppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 73.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.primary,
        ),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                left: -55.w,
                bottom: -100.h,
                child: Container(
                  width: 190.w,
                  height: 190.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.SlateBlueLight,
                  ),
                ),
              ),
              Positioned(
                right: -55.w,
                bottom: -100.h,
                child: Container(
                  width: 190.w,
                  height: 190.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.SlateBlueLight,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go(routes.searchScreen);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/search-normal.svg",
                        height: 30.h,
                        width: 30.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    SvgPicture.asset(
                      "assets/icons/notification.svg",
                      height: 30.h,
                      width: 30.w,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      "assets/images/logo_new.png",
                      height: 60.h,
                      width: 70.w,
                      fit: BoxFit.contain,
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
