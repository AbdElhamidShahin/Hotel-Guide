import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.onTap,
    required this.color,
    this.textColor = Colors.black,
  });

  final String? text;
  final VoidCallback? onTap;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize:  Size(260, 70),

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
        style: font18BoldGray.copyWith(color: AppColors.textWhite)
      ),
    );
  }
}
