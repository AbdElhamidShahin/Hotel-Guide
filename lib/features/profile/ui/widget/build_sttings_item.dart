import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_theme_data.dart';

Widget buildSttingsItem({
  required String title,
  required IconData icon,
  required VoidCallback onTap,
  bool isLast = false,
}) {
  return Builder(
    builder: (context) {
      final cs = Theme.of(context).colorScheme;
      return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    size: 24,
                    // onSurface = primary text colour — adapts in dark mode.
                    color: cs.onSurface,
                  ),
                  Row(
                    children: [
                      Text(
                        title,
                        // Migrated from frozen inline TextStyle with Colors.black.
                        style: AppTextStyles.font23SemiBoldBlack(context)
                            .copyWith(fontSize: 20.sp),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        icon,
                        // onSurfaceVariant = secondary icon colour.
                        color: cs.onSurfaceVariant,
                        size: 28,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!isLast)
              Divider(
                height: 1,
                // outline = themed divider — correct shade in both modes.
                color: cs.outline,
              ),
          ],
        ),
      );
    },
  );
}
