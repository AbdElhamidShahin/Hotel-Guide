import 'package:flutter/material.dart';
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
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xD9252530), Color(0xE6000000)],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/logo/logo.png"),
                  SizedBox(height: 100),

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
                        SizedBox(height: 16),
                        Text(
                          "اكتشف أفضل الفنادق... قارن واحجز بثقة وبأسرع طريقة.",
                          textAlign: TextAlign.right,
                          style: textStyle20RegularWhite,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 100),
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
