import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../../../core/router/routers.dart';
import 'background_circles.dart';

class CustomAppbarHome extends StatelessWidget {
  const CustomAppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 80.h,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.primary,
        ),
        child: Stack(
          children: [
            BackgroundCircle(left: -70.r, bottom: -110.r),
            BackgroundCircle(right: -70.r, bottom: -110.r),

            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    _buildAppBarIcon(context, "assets/icons/search-normal.svg", routes.searchScreen),
                    SizedBox(width: 12.w),
                    _buildAppBarIcon(context, "assets/icons/notification.svg", routes.notification),
                    const Spacer(),
                    Image.asset(
                      "assets/images/logo/logo_new.png",
                      height: 55.h,
                      width: 65.w,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),          ],
        ),
      ),
    );
  }Widget _buildAppBarIcon(BuildContext context, String icon, String route) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: SvgPicture.asset(
        icon,
        height: 28.r,
        width: 28.r,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }
}
