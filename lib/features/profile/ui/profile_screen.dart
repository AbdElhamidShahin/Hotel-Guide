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

    // ── Read current dark-mode state directly from the live theme.
    // This is the single source of truth — no local bool, no AppColors.isDark.
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // scaffoldBackgroundColor from AppThemeData — adapts automatically.
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

                      // ── Animated toggle pill ─────────────────────────
                      GestureDetector(
                        // ACTION: calls ThemeCubit.toggleTheme() on every tap.
                        // The Cubit saves the preference and emits the new
                        // ThemeMode. BlocBuilder in hotel_app.dart rebuilds
                        // the entire MaterialApp instantly.
                        onTap: () =>
                            context.read<ThemeCubit>().toggleTheme(),
                        child: Container(
                          width: 60.w,
                          height: 32.h,
                          padding: EdgeInsets.all(2.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              // outline = themed border — adapts in dark mode.
                              color: cs.outline,
                              width: 2.w,
                            ),
                          ),
                          child: AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            // STATE REFLECTION: pill position mirrors live brightness.
                            alignment: isDark
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: 24.r,
                              height: 24.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // Primary colour for the knob — consistent brand.
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

                      // ── Label ────────────────────────────────────────
                      Row(
                        children: [
                          Text(
                            'الوضع الليلي',
                            style: AppTextStyles.font23SemiBoldBlack(context)
                                .copyWith(fontSize: 20.sp),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.nightlight_outlined,
                            // onSurfaceVariant = secondary icon colour.
                            color: cs.onSurfaceVariant,
                            size: 24.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Themed divider — correct shade in both modes.
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Divider(height: 2, color: cs.outline),
                ),

                // ── Settings rows ────────────────────────────────────────
                buildSttingsItem(
                  title: 'الموقع',
                  icon: Icons.location_on_outlined,
                  onTap: () => context.push(routes.AboutUsScreen),
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
                  onTap: () {},
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
