import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackgroundDecorations(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.primary,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          try {
                            context.pop();
                          } catch (e) {
                            context.go(routes.homeScreen);
                          }
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 70.h),
                  Expanded(
                    child: ListView(
                      children: [
                        _MenuTile(
                          title: 'من نحن',
                          iconPath: 'assets/icons/menu_icons/people.svg',
                          onTap: () {},
                        ),
                        _MenuTile(
                          title: 'الأسئلة الشائعة',
                          iconPath: 'assets/icons/menu_icons/FAQ_Icon_UIA.svg',
                          onTap: () {},
                        ),
                        _MenuTile(
                          title: 'خريطة التطبيق',
                          iconPath: 'assets/icons/menu_icons/map.svg',
                          onTap: () {},
                        ),
                        _MenuTile(
                          title: 'اتصل بنا',
                          iconPath: 'assets/icons/menu_icons/call-calling.svg',
                          onTap: () {},
                        ),
                        _MenuTile(
                          title: 'سياسة الخصوصية',
                          iconPath: 'assets/icons/menu_icons/security-user.svg',
                          onTap: () {},
                        ),
                        _MenuTile(
                          title: 'الشروط والأحكام',
                          iconPath:
                              'assets/icons/menu_icons/clipboard-text.svg',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  _buildLogoutButton(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildLogoutButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.primary, width: 1.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(47)),
        padding: EdgeInsets.symmetric(horizontal: 60.h, vertical: 12.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('تسجيل الخروج', style: textStyle23Regularprimary),
          SizedBox(width: 8.w),
          SvgPicture.asset(
            "assets/icons/menu_icons/logout.svg",
            width: 30.w,
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const _MenuTile({
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
