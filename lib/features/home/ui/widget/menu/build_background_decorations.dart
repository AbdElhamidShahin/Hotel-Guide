import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBackgroundDecorations(BuildContext context) {
  final circleColor = Theme.of(context).colorScheme.outline.withOpacity(0.35);
  return Stack(
    children: [
      Positioned(
        top: -150.h,
        right: -150.w,
        child: Container(
          width: 300.w,
          height: 300.h,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
        ),
      ),
      Positioned(
        bottom: -150.h,
        right: -150.w,
        child: Container(
          width: 300.w,
          height: 300.h,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
        ),
      ),
    ],
  );
}
