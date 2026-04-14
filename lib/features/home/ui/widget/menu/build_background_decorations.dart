import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/colors.dart';

Widget buildBackgroundDecorations() {
  return Stack(
    children: [
      Positioned(
        top: -150.h,
        right: -150.w,
        child: Container(
          width: 300.w,
          height: 300.h,
          decoration: BoxDecoration(
            color: AppColors.border,
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        bottom: -150.h,
        right: -150.w,
        child: Container(
          width: 300.w,
          height: 300.h,
          decoration: BoxDecoration(
            color: AppColors.border,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ],
  );
}
