import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/router/routers.dart';
import '../../../core/theme/app_theme_data.dart';
import '../../../core/theme/colors.dart';
import 'widget/menu/build_background_decorations.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final contentColor = isDarkMode ? Colors.white : AppColors.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          buildBackgroundDecorations(context),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          contentColor: contentColor,
                        ),
                        _MenuTile(
                          title: 'الأسئلة الشائعة',
                          iconPath: 'assets/icons/menu_icons/FAQ_Icon_UIA.svg',
                          onTap: () => context.push(routes.FaqPage),
                          contentColor: contentColor,
                        ),
                        _MenuTile(
                          title: 'خريطة التطبيق',
                          iconPath: 'assets/icons/menu_icons/map.svg',
                          onTap: () => context.push(routes.SitemapScreen),
                          contentColor: contentColor,
                        ),
                        _MenuTile(
                          title: 'اتصل بنا',
                          iconPath: 'assets/icons/menu_icons/call-calling.svg',
                          onTap: () => context.push(routes.ContactUsScreen),
                          contentColor: contentColor,
                        ),
                        _MenuTile(
                          title: 'سياسة الخصوصية',
                          iconPath: 'assets/icons/menu_icons/security-user.svg',
                          onTap: () => context.push(routes.PrivacyPolicyScreen),
                          contentColor: contentColor,
                        ),
                        _MenuTile(
                          title: 'الشروط والأحكام',
                          iconPath:
                              'assets/icons/menu_icons/clipboard-text.svg',
                          onTap: () =>
                              context.push(routes.TermsConditionsScreen),
                          contentColor: contentColor,
                        ),
                      ],
                    ),
                  ),

                  // ── Logout button ─────────────────────────────────
                  _LogoutButton(contentColor: contentColor),
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
  final Color contentColor; // استقبال اللون الديناميكي

  const _MenuTile({
    required this.title,
    required this.iconPath,
    required this.onTap,
    required this.contentColor,
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
            color: contentColor, // يتغير ديناميكيًا
          ),
          title: Text(
            title,
            textAlign: TextAlign.right,
            // استخدام copyWith لتحديث لون النص فقط والحفاظ على بقية خصائص الـ Style ثابتة
            style: AppTextStyles.font23RegularPrimary(
              context,
            ).copyWith(color: contentColor),
          ),
          trailing: SvgPicture.asset(
            iconPath,
            width: 28.w,
            height: 28.h,
            colorFilter: ColorFilter.mode(
              contentColor,
              BlendMode.srcIn,
            ), // يتغير ديناميكيًا
          ),
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: contentColor.withOpacity(
            0.15,
          ), // يتناسب مع الخلفية والمود الحالي
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

// ── Logout button ─────────────────────────────────────────────────────────────

class _LogoutButton extends StatelessWidget {
  final Color contentColor; // استقبال اللون الديناميكي

  const _LogoutButton({required this.contentColor});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        await Supabase.instance.client.auth.signOut();
        if (context.mounted) context.go(routes.onBoardingScreen);
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: contentColor,
          width: 1.2.w,
        ), // إطار الزر يتغير مع المود
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(47.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 14.h),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'تسجيل الخروج',
            style: AppTextStyles.font23RegularPrimary(context).copyWith(
              color: contentColor, // نص زر الخروج يتغير حسب المود
            ),
          ),
          SizedBox(width: 10.w),
          SvgPicture.asset(
            'assets/icons/menu_icons/logout.svg',
            width: 26.w,
            height: 26.h,
            colorFilter: ColorFilter.mode(
              contentColor,
              BlendMode.srcIn,
            ), // لون الأيقونة ديناميكي
          ),
        ],
      ),
    );
  }
}
