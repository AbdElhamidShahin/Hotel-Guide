import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme_data.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        // outline = themed divider colour — replaces AppColors.softGray (dead flag).
        Expanded(child: Divider(color: cs.outline, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          // Migrated from frozen font16RegularMuted global.
          child: Text(
            'أو',
            style: AppTextStyles.font16RegularMuted(context).copyWith(fontSize: 12.sp),
          ),
        ),
        Expanded(child: Divider(color: cs.outline, thickness: 1)),
      ],
    );
  }
}
