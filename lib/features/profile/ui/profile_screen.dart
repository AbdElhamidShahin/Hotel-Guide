import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/cubit/theme_cubit.dart';
import 'package:hotel_guide/features/profile/ui/widget/build_sttings_item.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_profile_image_and_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/helpers/local_storage_account.dart';
import '../../../core/theme/colors.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    UserDataNotifier.instance.addListener(_onUserDataChanged);
    UserDataNotifier.instance.load();
  }

  void _onUserDataChanged() => setState(() {});

  @override
  void dispose() {
    UserDataNotifier.instance.removeListener(_onUserDataChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = UserDataNotifier.instance;
    final cs = Theme.of(context).colorScheme;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          CustomProfileImageAndName(
            showEditIcon: true,
            name: notifier.name.isNotEmpty ? notifier.name : 'مستخدم',
            imageUrl: notifier.image.isNotEmpty ? notifier.image : null,
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                // ── Dark mode toggle ─────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.read<ThemeCubit>().toggleTheme(),
                        child: Container(
                          width: 60.w,
                          height: 32.h,
                          padding: EdgeInsets.all(2.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(color: cs.outline, width: 2.w),
                          ),
                          child: AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            alignment: isDark
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: 24.r,
                              height: 24.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                              ),
                              child: Icon(
                                isDark
                                    ? Icons.nightlight_outlined
                                    : Icons.wb_sunny_outlined,
                                // Always white — icon on primary-colour circle.
                                color: Colors.white,
                                size: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Text(
                            isDark ? 'الوضع الفاتح' : 'الوضع الليلي',
                            style: AppTextStyles.font23SemiBoldBlack(context)
                                .copyWith(
                                  fontSize: 20.sp,
                                  color: isDark ? Colors.white : cs.onSurface,
                                ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            isDark
                                ? Icons.light_mode_outlined
                                : Icons.nightlight_outlined,
                            color: cs.onSurfaceVariant,
                            size: 24.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Divider(height: 2, color: cs.outline),
                ),

                buildSttingsItem(
                  title: 'خريطة التطبيق',
                  icon: Icons.location_on_outlined,
                  onTap: () => context.push(routes.SitemapScreen),
                ),
                buildSttingsItem(
                  title: 'الموقع',
                  icon: Icons.location_on_outlined,
                  onTap: () {},
                ),
                buildSttingsItem(
                  title: 'سياسة الخصوصية',
                  icon: Icons.assignment_outlined,
                  onTap: () => context.push(routes.PrivacyPolicyScreen),
                ),
                buildSttingsItem(
                  title: 'الأسئلة الشائعة',
                  icon: Icons.help_outline,
                  onTap: () => context.push(routes.FaqPage),
                ),
                buildSttingsItem(
                  title: 'شروط الإستخدام',
                  icon: Icons.book_outlined,
                  onTap: () => context.push(routes.TermsConditionsScreen),
                ),
                buildSttingsItem(
                  title: 'تسجيل الخروج',
                  icon: Icons.login_rounded,
                  isLast: true,
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    await Supabase.instance.client.auth.signOut();
                    if (context.mounted) context.go(routes.onBoardingScreen);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
