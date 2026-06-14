import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.onTap,
    required this.color,
    this.textColor,
  });

  final String? text;
  final VoidCallback? onTap;
  final Color color;
  // textColor is kept optional — callers that relied on it still compile.
  // When null, white is used (correct for primary-coloured buttons).
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(260, 70),
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
          side: BorderSide(color: color),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
        // Migrated from frozen font18BoldGray.copyWith(color: textWhite).
        // Always white — button sits on a brand-colour background.
        style: AppTextStyles.font18BoldGray(context).copyWith(
          color: textColor ?? AppColors.textWhite,
        ),
      ),
    );
  }
}
