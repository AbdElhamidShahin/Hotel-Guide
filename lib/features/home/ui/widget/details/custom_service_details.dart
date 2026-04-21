import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class CustomServiceDetails extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;

  const CustomServiceDetails({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.warningColor.withOpacity(.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? const Color(0xFF535367), size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: font16BoldWhite.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
