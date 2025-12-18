import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors.dart';

class BackgroundCircle extends StatelessWidget {
  const BackgroundCircle({
    super.key,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container(
        width: 190.w,
        height: 190.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.SlateBlueLight,
        ),
      ),
    );
  }
}
