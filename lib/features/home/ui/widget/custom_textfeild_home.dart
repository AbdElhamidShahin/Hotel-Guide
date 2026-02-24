import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class CustomTextfeildHome extends StatelessWidget {
  const CustomTextfeildHome({
    super.key,
    required this.title,
    required this.text,
    required this.image,
    required this.height,
    required this.width,
  });
  final String title;
  final String text;
  final String image;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 54.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(80.r),
          border: Border.all(color: AppColors.SlateBlueLight, width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              width: 80.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.white24, width: 1.w),
                ),
              ),
              child: Text(
                title,
                style: textStyle16BoldWhite.copyWith(fontSize: 14.sp),
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.all(4.r),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.SlateBlueLight,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: textStyle16BoldWhite.copyWith(fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SvgPicture.asset(image, width: width.r, height: height.r),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
