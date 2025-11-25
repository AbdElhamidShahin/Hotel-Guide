import 'package:flutter/material.dart';
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
          Container(
            width: 111,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColors.yellowSoft, width: 2),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                topLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "إكتشف المزيد",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 13,
                  fontFamily: 'Cairo',

                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          Spacer(),
          Text(
            "الأعلى تقييمًا...",
            style: textStyle23SemiBoldBlack.copyWith(
              color: AppColors.black3,

              fontSize: 22,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
