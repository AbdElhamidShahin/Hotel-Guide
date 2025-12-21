import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/colors.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const MenuTile({
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
          leading: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: AppColors.primary,
          ),
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: textStyle23Regularprimary,
          ),
          trailing: SvgPicture.asset(
            iconPath,
            width: 30.w,
            height: 30.h,
            color: AppColors.primary,
          ),
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: AppColors.primary.withOpacity(0.2),
        ),
        SizedBox(height: 28.h),
      ],
    );
  }
}
