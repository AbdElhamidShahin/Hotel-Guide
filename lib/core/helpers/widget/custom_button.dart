import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.text, this.onTap});

  final String? text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: AppColors.primary, width: 2),
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Text(text ?? '', style: AppTextStyles.font16BoldWhite(context)),
    );
  }
}
