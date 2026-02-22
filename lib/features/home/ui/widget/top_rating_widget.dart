import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
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
                    "assets/icons/received.svg",
                    colorFilter: ColorFilter.mode(
                      AppColors.ShadowPurple,
                      BlendMode.srcIn,
                    ),
                    width: 20.r,
                    height: 20.r,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "عرض المزيد",
                    style: textStyle18RegularShadowPurple.copyWith(
                      fontSize: 16.sp,
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
              style: textStyle20BoldShadowPurple.copyWith(
                fontSize: 18.sp,
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