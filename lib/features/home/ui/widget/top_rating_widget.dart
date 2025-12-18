import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class TopRatingWidget extends StatelessWidget {
  const TopRatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
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
                  style: textStyle12RegularShadowPurple,
                ),
              ],
            ),
          ),
          Spacer(),

          Text(
            "الأكثر حجزًا هذا الأسبوع",
            textAlign: TextAlign.center,
            style: textStyle20BoldShadowPurple,
          ),
        ],
      ),
    );
  }
}
