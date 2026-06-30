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
    // تحديد اللون ديناميكيًا بناءً على حالة الـ Theme الحالي (Dark / Light)
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final contentColor = isDarkMode ? Colors.white : AppColors.primary;

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
          leading: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: contentColor, // تعديل ديناميكي
          ),
          title: Text(
            title,
            textAlign: TextAlign.right,
            // تعديل لتغيير اللون ديناميكيًا مع الحفاظ على الاستايل الأساسي
            style: AppTextStyles.font23RegularPrimary(
              context,
            ).copyWith(color: contentColor),
          ),
          trailing: SvgPicture.asset(
            iconPath,
            width: 30.w,
            height: 30.h,
            colorFilter: ColorFilter.mode(
              contentColor,
              BlendMode.srcIn,
            ), // تعديل ديناميكي
          ),
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: contentColor.withOpacity(0.2), // تعديل ديناميكي ليكون متناسقًا
        ),
        SizedBox(height: 28.h),
      ],
    );
  }
}
