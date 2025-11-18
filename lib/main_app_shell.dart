import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart'; // Assuming AppColors.black and AppColors.orangeGold exist here

class MainAppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainAppShell({super.key, required this.navigationShell});

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  // دالة بناء عنصر شريط التنقل (تم تصحيحها وإزالة التكرار)
  Widget _buildNavItem({
    required String defaultAsset,
    required String selectedAsset,
    required int index,
    required bool hasBadge, // لم يتم استخدامها هنا، ولكن يمكن إضافتها لاحقًا
  }) {
    final bool isSelected = navigationShell.currentIndex == index;

    // 1. منطق تلوين الأيقونة: أسود للمختار ورمادي لغير المختار
    final Color iconColor = isSelected ? AppColors.black : Colors.grey.shade600;

    // 2. منطق تلوين الخلفية: برتقالي فاتح للمختار، وشفاف لغير المختار
    final Color backgroundColor = isSelected
        ? AppColors.orangeGold.withOpacity(0.2)
        : Colors.transparent;

    Widget iconWidget = SvgPicture.asset(
      isSelected ? selectedAsset : defaultAsset,
      height: 28, // حجم الأيقونة
      width: 28,
      // استخدام ColorFilter لتلوين ملفات SVG بشكل صحيح
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
    );

    // 3. يتم تغليف الأيقونة في حاوية لتطبيق الخلفية والحدود الدائرية
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      // إضافة Padding متساوي (8) لجعل الخلفية تبدو كمربع مستدير
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: iconWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    // تم تصحيح منطق الـ PopScope ليطابق التصميم القياسي GoRouter
    return PopScope(
      canPop: navigationShell.currentIndex == 3
          ? false
          : true, // يمكن العودة إلا إذا كنا في الهوم
      onPopInvoked: (bool didPop) {
        if (didPop) return;

        // إذا كنا في أي تاب غير الهوم (index 3)، نعود للهوم
        if (navigationShell.currentIndex != 3) {
          navigationShell.goBranch(3); // الانتقال إلى الهوم (index 3)
        } else {
          // إذا كنا في الهوم ولا يمكن العودة، نخرج من التطبيق
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => _onTap(context, index),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              // Index 0: المستخدم
              BottomNavigationBarItem(
                icon: _buildNavItem(
                  defaultAsset:
                  'assets/icons/Icons_bar/user-alt-1-svgrepo-com.svg',
                  selectedAsset:
                  'assets/icons/icon_bar_active/user-svgrepo-com.svg',
                  index: 0,
                  hasBadge: false,
                ),
                label: '',
              ),
              // Index 1: الإشعارات
              BottomNavigationBarItem(
                icon: _buildNavItem(
                  defaultAsset:
                  'assets/icons/Icons_bar/bell-bing-svgrepo-com.svg',
                  selectedAsset:
                  'assets/icons/icon_bar_active/bell-bing-svgrepo-com.svg',
                  index: 1,
                  hasBadge: true,
                ),
                label: '',
              ),
              // Index 2: المفضلة
              BottomNavigationBarItem(
                icon: _buildNavItem(
                  defaultAsset:
                  'assets/icons/Icons_bar/favorite-heart-like-love-alert-notification-svgrepo-com.svg',
                  selectedAsset:
                  'assets/icons/icon_bar_active/favorite-filled-svgrepo-com.svg',
                  index: 2,
                  hasBadge: false,
                ),
                label: '',
              ),
              // Index 3: الرئيسية
              BottomNavigationBarItem(
                icon: _buildNavItem(
                  defaultAsset:
                  'assets/icons/Icons_bar/home-angle-2-svgrepo-com.svg',
                  selectedAsset:
                  'assets/icons/icon_bar_active/home-angle-2-svgrepo-com.svg',
                  index: 3,
                  hasBadge: true,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
  //
//
}