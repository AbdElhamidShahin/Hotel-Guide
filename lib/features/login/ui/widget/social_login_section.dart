import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconSocial("assets/icons/google.svg"),

        SizedBox(height: 8.w),
        IconSocial("assets/icons/2021_Facebook_icon 1.svg"),
      ],
    );
  }
}

Widget IconSocial(String image) {
  return Container(
    width: double.infinity,
    height: 50.h,
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.Milk, // Your custom color
        width: 2.0, // Thickness of the border
      ),
      borderRadius: BorderRadius.circular(12),
      color: AppColors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "التسجيل حساب جوجل",
          style: textStyle16BoldWhite.copyWith(color: AppColors.Nightfall),
        ),
        SizedBox(width: 12.w),
        SvgPicture.asset(image, width: 28.w, height: 28.h),
      ],
    ),
  );
}
