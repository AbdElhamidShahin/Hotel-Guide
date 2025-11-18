import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class MainAppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainAppShell({super.key, required this.navigationShell});

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  Widget _buildNavItem({
    required String defaultAsset,
    required String selectedAsset,
    required int index,
    required bool hasBadge,
    Color selectedColor = AppColors.yellowSoft,
    Color unselectedColor = Colors.black54,
  }) {
    final bool isSelected = navigationShell.currentIndex == index;

    final Color iconColor = isSelected ? selectedColor : unselectedColor;

    Widget iconWidget = SvgPicture.asset(
      isSelected ? selectedAsset : defaultAsset,
      height: 30,
      width: 30,
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: iconWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;

        // إذا كنا في أي تاب غير الهوم (index 3)، نعود للهوم
        if (navigationShell.currentIndex != 3) {
          navigationShell.goBranch(3); // الانتقال إلى الهوم (index 3)
        } else {
          // إذا كنا في الهوم ولا يمكن العودة، نخرج من التطبيق
          final canPop = GoRouter.of(context).canPop(); // ✅ التصحيح هنا
          if (canPop) {
            context.pop(); // العودة في الـ navigation stack
          } else {
            SystemNavigator.pop(); // الخروج من التطبيق
          }
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
}//