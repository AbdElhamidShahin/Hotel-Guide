import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_theme_data.dart';
import '../../../../../core/theme/colors.dart';

/// Branded header strip used in the hotel details screen and description sheet.
/// Background is always AppColors.primary — it is a brand banner, not a surface.
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
        // Intentionally primary — brand header, same in both themes.
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
                // Migrated from frozen font20BoldShadowPurple.copyWith(color: textWhite).
                // Always white — text sits on primary-colour banner.
                style: AppTextStyles.font20BoldShadowPurple(context).copyWith(
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
