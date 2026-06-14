import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';

Widget CustomItemSetteings(String text, VoidCallback? onPressed) {
  return Builder(
    builder: (context) {
      final cs = Theme.of(context).colorScheme;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: AppTextStyles.font23SemiBoldBlack(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.warning,
                    ),
                  ),
                ),
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
            Divider(
              // outline = themed divider, correct in both modes.
              color: cs.outline,
            ),
          ],
        ),
      );
    },
  );
}
