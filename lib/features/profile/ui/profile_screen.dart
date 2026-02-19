import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/profile/ui/widget/build_sttings_item.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_profile_image_and_name.dart';
import '../../../core/helpers/local_storage_account.dart';
import '../../../core/theme/colors.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, this.name});
  final String? name;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? name;
  String? profileImage;
  @override
  void initState() {
    super.initState();
    name = widget.name;
    _loadIfNeeded();
  }

  Future<void> _loadIfNeeded() async {
    if (name == null || name!.isEmpty) {
      final data = await UserDataManager.loadUserData();
      setState(() {
        name = data['name'] ?? '';
        profileImage = data['image'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomProfileImageAndName(showEditIcon: true, name: name),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 65,
                          height: 35,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey, width: 2.5),
                          ),
                          child: Stack(
                            children: [
                              AnimatedAlign(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                                alignment: isDarkMode
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF181A20),
                                  ),
                                  child: const Icon(
                                    Icons.wb_sunny_outlined,
                                    color: Colors.white,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "الوضع الليلي",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Cairo',

                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.nightlight_outlined,
                            color: AppColors.black4,

                            size: 24,
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
                  onTap: () {},
                ),
                buildSttingsItem(
                  title: "سياسة الخصوصية",
                  icon: Icons.assignment_outlined,
                  onTap: () {},
                ),
                buildSttingsItem(
                  title: "الأسئلة الشائعة",
                  icon: Icons.help_outline,
                  onTap: () {},
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
                  onTap: () {
                    context.go(routes.onBoardingScreen);
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