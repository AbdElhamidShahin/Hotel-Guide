import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/colors.dart';

class CustomNameDetails extends StatelessWidget {
  const CustomNameDetails({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73.h,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.primary,
      ),
      child: Stack(
        children: [
          Positioned(
            left: -50.r,
            bottom: -20.r,
            child: Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.SlateBlueLight.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            right: -60.w,
            top: -12,
            child: Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.SlateBlueLight,
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                name,
                style: font20BoldShadowPurple.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
