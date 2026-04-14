import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/features/room/ui/widget/room_details_page.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';

class FacilityItem extends StatelessWidget {
  final FacilityModel facility;

  const FacilityItem({super.key, required this.facility});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = facility.isAvailable
        ? AppColors.ShadowPurple
        : AppColors.error;

    final IconData icon = facility.isAvailable
        ? Icons.check_circle_outline_rounded
        : Icons.cancel_outlined;

    final Color borderColor = facility.isAvailable
        ? AppColors.ShadowPurple.withOpacity(0.5)
        : AppColors.error;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(5.r),
        color: facility.isAvailable ? Colors.transparent : AppColors.dangerRed.withOpacity(0.02),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24.sp, color: mainColor),
          SizedBox(width: 8.w),
          Text(
            facility.title,
            style: textStyle16RegularGray.copyWith(
              color: mainColor,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}