import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/router/routers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/colors.dart';
import 'widget/menu/build_background_decorations.dart';

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Close button ─────────────────────────────────
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
                          size: 28,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          try {
                            context.pop();
                          } catch (_) {
                            context.push(routes.homeScreen);
                          }
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 48.h),

                  // ── Menu items ────────────────────────────────────
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _MenuTile(
                          title: 'من نحن',
                          iconPath: 'assets/icons/menu_icons/people.svg',
                          onTap: () => context.push(routes.AboutUsScreen),
                        ),
                        _MenuTile(
                          title: 'الأسئلة الشائعة',
                          iconPath: 'assets/icons/menu_icons/FAQ_Icon_UIA.svg',
                          onTap: () => context.push(routes.FaqPage),
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
                          onTap: () => context.push(routes.PrivacyPolicyScreen),
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

                  // ── Logout button ─────────────────────────────────
                  _LogoutButton(),
                  SizedBox(height: 36.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Menu tile ─────────────────────────────────────────────────────────────────

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
            size: 22,
            color: AppColors.primary,
          ),
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: font23RegularPrimary,
          ),
          trailing: SvgPicture.asset(
            iconPath,
            width: 28.w,
            height: 28.h,
            // ignore: deprecated_member_use
            color: AppColors.primary,
          ),
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: AppColors.primary.withOpacity(0.15),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

// ── Logout button ─────────────────────────────────────────────────────────────

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        await Supabase.instance.client.auth.signOut();
        if (context.mounted) context.go(routes.onBoardingScreen);
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.primary, width: 1.2.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(47.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 14.h),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('تسجيل الخروج', style: font23RegularPrimary),
          SizedBox(width: 10.w),
          SvgPicture.asset(
            'assets/icons/menu_icons/logout.svg',
            width: 26.w,
            height: 26.h,
          ),
        ],
      ),
    );
  }
}
