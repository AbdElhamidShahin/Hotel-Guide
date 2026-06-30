import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
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
          onTap: () => context.read<SignUpCubit>().signUpWithGoogle(),
          child: iconSocial(
            context,
            'assets/icons/google.svg',
            'التسجيل حساب جوجل',
          ),
        ),
        SizedBox(height: 8.w),
      ],
    );
  }
}

Widget iconSocial(BuildContext context, String image, String text) {
  final cs = Theme.of(context).colorScheme;
  return Container(
    width: double.infinity,
    height: 52.h,
    decoration: BoxDecoration(
      border: Border.all(color: cs.outline, width: 1.5),
      borderRadius: BorderRadius.circular(12.r),
      color: cs.surface,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppTextStyles.font16BoldWhite(
            context,
          ).copyWith(color: cs.onSurface),
        ),
        SizedBox(width: 12.w),
        SvgPicture.asset(image, width: 22.r, height: 22.r),
      ],
    ),
  );
}
