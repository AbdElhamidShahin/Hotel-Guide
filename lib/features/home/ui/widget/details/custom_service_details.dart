import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
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
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor ?? cs.onSurfaceVariant,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTextStyles.font16BoldWhite(context).copyWith(
              color: cs.onSurface, // التعديل: ليصبح النص متباين وواضح جداً في الوضعين
            ),
          ),
        ],
      ),
    );
  }
}