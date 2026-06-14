import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';

Widget CustomDetailRow(String title, String supTitle, String image, Color color) {
  return Builder(
    builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final cs = Theme.of(context).colorScheme;
      return Row(
        children: [
          Text(title, style: AppTextStyles.font16RegularMuted(context).copyWith(color: isDark ? Colors.white : color)),          const Spacer(),
          Text(
            supTitle,
            style: AppTextStyles.font16RegularMuted(context).copyWith(
              color: isDark ? cs.onSurfaceVariant : cs.primary,
            ),
          ),          SizedBox(width: 8.w),
          SvgPicture.asset(
            image,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(
              isDark ? cs.onSurfaceVariant : cs.primary,
              BlendMode.srcIn,
            ),
          ),
        ],
      );
    },
  );
}