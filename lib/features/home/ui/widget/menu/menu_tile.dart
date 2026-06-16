import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/theme/app_theme_data.dart';
import '../../../../../core/theme/colors.dart';

/// Standalone MenuTile — kept in case it is imported directly anywhere.
/// menu_screen.dart uses its own private _MenuTile, but this public version
/// is migrated in parallel for completeness.
class MenuTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const MenuTile({
    super.key,
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
            // Migrated from frozen font23RegularPrimary global.
            style: AppTextStyles.font23RegularPrimary(context),
          ),
          trailing: SvgPicture.asset(
            iconPath,
            width: 30.w,
            height: 30.h,
            // Replaced deprecated color: with colorFilter.
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
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
