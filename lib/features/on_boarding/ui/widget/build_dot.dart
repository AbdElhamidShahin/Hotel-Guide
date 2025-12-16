
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors.dart';

Widget buildDot(int index,currentIndex) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    height: 8.h,
    width: currentIndex == index ? 30.w : 8.w,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: currentIndex == index
          ? AppColors.primary
          : AppColors.hintTextGrey.withOpacity(0.5),
    ),
  );
}