import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class TopRatingWidget extends StatelessWidget {
  TopRatingWidget({super.key, required this.name, required this.onTap});
  final String name;
  final   VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/received.svg",
                  color: AppColors.ShadowPurple,
                  width: 24,
                  height: 24,
                ),

                Text(
                  "عرض المزيد  ",
                  textAlign: TextAlign.center,
                  style: textStyle18RegularShadowPurple,
                ),
              ],
            ),
          ),
          Spacer(),

          Text(
            name,
            textAlign: TextAlign.center,
            style: textStyle20BoldShadowPurple,
          ),
        ],
      ),
    );
  }
}
