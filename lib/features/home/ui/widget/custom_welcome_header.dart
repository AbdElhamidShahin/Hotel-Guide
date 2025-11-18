import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';

class CustomWelcomeHeader extends StatelessWidget {
  const CustomWelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "مرحبًا شادي، جاهز لبدء رحلتك؟",
                style: textStyle23SemiBoldBlack,
              ),
              SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(46.5),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  "assets/images/profile.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            ".كل ما تحتاجه للإقامة المثالية أصبح بين يديك الآن",
            style: textStyle17MediumBlack,
          ),
        ],
      ),
    );
  }
}
