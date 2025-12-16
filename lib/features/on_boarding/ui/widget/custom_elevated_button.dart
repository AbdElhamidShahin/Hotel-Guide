import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.70.w,
      height: 66.h,
      child: ElevatedButton(
        onPressed: () {
          context.go(routes.loginScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.DarkPurpleGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide( width: 2),
          ),
        ),
        child: Text('ابدأ الآن', style: textStyle25SemiBoldWhite),
      ),
    );
  }
}
