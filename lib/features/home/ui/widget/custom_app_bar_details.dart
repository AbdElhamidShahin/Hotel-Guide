import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/colors.dart';

import '../../../../core/theme/app_theme.dart';

class CustomAppBarDetails extends StatelessWidget {
  const CustomAppBarDetails({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          const Spacer(),
          Text(
            title,
            style: textStyle23SemiBoldBlack.copyWith(
              color: AppColors.black6.withOpacity(0.8),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              context.go(routes.homeScreen);
            },
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
