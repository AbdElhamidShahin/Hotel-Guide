import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors.dart';

Widget buildDot(int index, int currentIndex) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    height: 8.h,
    width: currentIndex == index ? 28.w : 8.w,
    margin: EdgeInsets.only(right: 6.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: currentIndex == index
          ? AppColors.primary
          : AppColors.hintTextGrey.withOpacity(0.4),
    ),
  );
}
