import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class CustomServiceDetails extends StatelessWidget {
  const CustomServiceDetails({
    super.key,
    required this.text,
    required this.icon,
    this.color,
  });
  final String text;
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.warningColor.withOpacity(0.15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: color ?? AppColors.black7),
            SizedBox(width: 6),
            Text(
              text.length > 14 ? '${text.substring(0, 14)}...' : text,
              textDirection: TextDirection.rtl,
              style: textStyle14SemiBoldWhite.copyWith(color: AppColors.black7),
            ),
          ],
        ),
      ),
    );
  }
}
