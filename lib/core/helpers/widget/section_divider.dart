import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Divider(
        height: 2.h,
        thickness: 1.h,
        color: AppColors.pureBlack.withOpacity(0.1),
      ),
    );
  }
}
