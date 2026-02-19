import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // لا تنسى الـ import ده
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

import '../../../sign_up/logic/cubit/sign_up_cubit.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            context.read<SignUpCubit>().signUpWithGoogle();
          },
          child: iconSocial("assets/icons/google.svg", 'التسجيل حساب جوجل'),
        ),

        SizedBox(height: 8.w),

        GestureDetector(
          onTap: () {
          },
          child: iconSocial(
            "assets/icons/2021_Facebook_icon 1.svg",
            'التسجيل حساب فيس بوك',
          ),
        ),
      ],
    );
  }
}

Widget iconSocial(String image, String text) {
  return Container(
    width: double.infinity,
    height: 50.h,
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.Milk,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(12),
      color: AppColors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: textStyle16BoldWhite.copyWith(color: AppColors.Nightfall),
        ),
        SizedBox(width: 12.w),
        SvgPicture.asset(image, width: 28.w, height: 28.h),
      ],
    ),
  );
}