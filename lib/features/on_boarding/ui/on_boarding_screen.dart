import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/on_boarding/ui/widget/custom_elevated_button.dart';
import '../../../core/theme/app_theme.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/onBoardingImage.jpg",
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.6)),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 130),
                  Image.asset(
                    "assets/images/logo/logo.png",
                    width: 270,
                    height: 340,
                  ),

                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "رحلتك تبدأ من هنا!",
                          style: textStyle33BoldGray,
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "اكتشف أفضل الفنادق... قارن واحجز بثقة وبأسرع طريقة.",
                          textAlign: TextAlign.right,
                          style: textStyle20RegularWhite,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 134.h),
                  CustomElevatedButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
