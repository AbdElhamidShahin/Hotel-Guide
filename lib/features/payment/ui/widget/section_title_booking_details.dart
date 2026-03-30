import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle20BoldShadowPurple.copyWith(color: AppColors.black6),
    );
  }
}
