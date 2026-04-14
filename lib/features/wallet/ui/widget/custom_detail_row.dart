
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

Row CustomDetailRow(String title, String supTitle, String image, Color color) {
  return Row(
    children: [
      Text(title, style: font16RegularMuted.copyWith(color: color)),
      Spacer(),
      Text(
        supTitle,
        style: font16RegularMuted.copyWith(color: AppColors.primary),
      ),
      SizedBox(width: 8.w),
      SvgPicture.asset(image),
    ],
  );
}