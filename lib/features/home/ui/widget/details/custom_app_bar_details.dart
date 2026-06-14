import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';

class CustomAppBarDetails extends StatelessWidget {
  const CustomAppBarDetails({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          const Spacer(),
          Text(
            title,
            style: AppTextStyles.font23SemiBoldBlack(context).copyWith(
              color: cs.onSurface, // التعديل: لضمان تحوله للون الأبيض في الـ Dark Mode
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_forward,
              color: cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}