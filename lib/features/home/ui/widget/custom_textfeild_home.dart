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
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.SlateBlueLight, width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.primary,
                border: Border(
                  left: BorderSide(color: Colors.white24, width: 1.w),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: textStyle16BoldWhite.copyWith(fontSize: 20.sp),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 3.w,
                  right: 14.w,
                  bottom: 2.h,
                  top: 2.h,
                ),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.SlateBlueLight,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white24),
                  ),

                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: SvgPicture.asset(
                              image,
                              height: height,
                              width: width,
                            ),
                          ),
                        ),
                        Text(
                          text,
                          style: textStyle16BoldWhite.copyWith(fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
