import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Divider(
        height: 2.h,
        thickness: 1.h,
        // DividerThemeData in AppThemeData supplies the correct color for
        // both light (0xFFD9D9D9) and dark (0xFF3A3A4A) automatically.
        color: Theme.of(context).dividerTheme.color,
      ),
    );
  }
}
