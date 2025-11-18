import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/colors.dart';

import '../../theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.text, this.onTap});

  final String? text;
  final VoidCallback? onTap;
//..
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
          side: BorderSide(color: AppColors.white.withOpacity(0.10), width: 2),
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Text(text ?? '', style: textStyle22RegularWhite),
    );
  }
}
