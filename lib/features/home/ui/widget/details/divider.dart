import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return           Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        color: AppColors.black.withOpacity(0.1),
      ),
    );
  }
}
