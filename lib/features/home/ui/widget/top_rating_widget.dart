import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class TopRatingWidget extends StatelessWidget {
  const TopRatingWidget({super.key, required this.name, required this.onTap});

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/received.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : AppColors.primary,
                      BlendMode.srcIn,
                    ),
                    width: 20.r,
                    height: 20.r,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'عرض المزيد',
                    style: AppTextStyles.font18RegularShadowPurple(context).copyWith(
                      fontSize: 16.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Text(
              name,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: AppTextStyles.font20BoldShadowPurple(context).copyWith(
                fontSize: 18.sp,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AppColors.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}