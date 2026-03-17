import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/menu/build_background_decorations.dart';
import 'package:hotel_guide/features/home/ui/widget/menu/menu_tile.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          buildBackgroundDecorations(),
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
                            context.push(routes.homeScreen);
                          }
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 70.h),
                  Expanded(
                    child: ListView(
                      children: [
                        MenuTile(
                          title: 'من نحن',
                          iconPath: 'assets/icons/menu_icons/people.svg',
                          onTap: () {},
                        ),
                        MenuTile(
                          title: 'الأسئلة الشائعة',
                          iconPath: 'assets/icons/menu_icons/FAQ_Icon_UIA.svg',
                          onTap: () {},
                        ),
                        MenuTile(
                          title: 'خريطة التطبيق',
                          iconPath: 'assets/icons/menu_icons/map.svg',
                          onTap: () {},
                        ),
                        MenuTile(
                          title: 'اتصل بنا',
                          iconPath: 'assets/icons/menu_icons/call-calling.svg',
                          onTap: () {},
                        ),
                        MenuTile(
                          title: 'سياسة الخصوصية',
                          iconPath: 'assets/icons/menu_icons/security-user.svg',
                          onTap: () {},
                        ),
                        MenuTile(
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
      onPressed: () {
        context.push(routes.onBoardingScreen);
      },
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
