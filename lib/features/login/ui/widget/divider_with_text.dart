import 'package:flutter/cupertino.dart' ;
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart' ;

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.white.withOpacity(0.40),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'يمكنك التسجيل عبر حسابك على',
            style: textStyle16mediumWhite.copyWith(fontSize: 18),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.white.withOpacity(0.40),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
