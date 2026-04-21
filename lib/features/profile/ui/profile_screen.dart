import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/profile/ui/widget/build_sttings_item.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_profile_image_and_name.dart';
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
    bool isDarkMode = false;
    final notifier = UserDataNotifier.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomProfileImageAndName(
            showEditIcon: true,
            name: notifier.name.isNotEmpty ? notifier.name : 'مستخدم', // ✅
            imageUrl: notifier.image.isNotEmpty ? notifier.image : null, // ✅
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 60.w,
                          height: 32.h,
                          padding: EdgeInsets.all(2.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 2.w,
                            ),
                          ),
                          child: AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            alignment: isDarkMode
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: 24.r,
                              height: 24.r,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF181A20),
                              ),
                              child: Icon(
                                Icons.wb_sunny_outlined,
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
                            "الوضع الليلي",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Cairo',

                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.nightlight_outlined,
                            color: AppColors.textTitle,

                            size: 24.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    height: 2,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),

                buildSttingsItem(
                  title: "الموقع",
                  icon: Icons.location_on_outlined,
                  onTap: () => context.push(routes.AboutUsScreen),
                ),
                buildSttingsItem(
                  title: "سياسة الخصوصية",
                  icon: Icons.assignment_outlined,
                  onTap: () => context.push(routes.PrivacyPolicyScreen),
                ),
                buildSttingsItem(
                  title: "الأسئلة الشائعة",
                  icon: Icons.help_outline,
                  onTap: () => context.push(routes.FaqPage),

                ),
                buildSttingsItem(
                  title: "شروط الإستخدام",
                  icon: Icons.book_outlined,
                  onTap: () {},
                ),

                buildSttingsItem(
                  title: "تسجيل الخروج",
                  icon: Icons.login_rounded,
                  isLast: true,
                  onTap: () async {
                    // ✅ Clear local SharedPreferences cache before signing out
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();

                    await Supabase.instance.client.auth.signOut();

                    if (context.mounted) {
                      context.go(routes.onBoardingScreen);
                    }
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
