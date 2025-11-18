import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart';
=======
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart'; // Assuming AppColors.black and AppColors.orangeGold exist here
>>>>>>> development-

class MainAppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainAppShell({super.key, required this.navigationShell});

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

<<<<<<< HEAD
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
=======
  // --- THIS FUNCTION IS UPDATED ---
  Widget _buildNavItem({
    required String assetPath,
    required int index,
    required bool hasBadge,
  }) {
    final bool isSelected = navigationShell.currentIndex == index;

    // 1. Updated color logic: Unselected icons are grey, selected is black.
    final Color iconColor =
    isSelected ? AppColors.black : Colors.grey.shade600;

    // 2. Your background color logic: This is correct.
    final Color backgroundColor = isSelected
        ? AppColors.orangeGold.withOpacity(0.2)
        : Colors.transparent;

    Widget iconWidget = SvgPicture.asset(
      assetPath,
      height: 28,
      width: 28,
      // Use ColorFilter for better and more reliable SVG tinting
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
    );

    // 3. THIS IS THE MAIN FIX:
    // Wrap the icon in a Container (or AnimatedContainer) to show
    // the selected background color.
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      // Change padding to be equal, making it a square
      padding: const EdgeInsets.all(8), // <-- CHANGED
      decoration: BoxDecoration(
        color: backgroundColor,
        // Change border radius to make it a rounded square, not a pill
        borderRadius: BorderRadius.circular(10), // <-- CHANGED
      ),
>>>>>>> development-
      child: iconWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return Scaffold(
      body: navigationShell,
      // --- THIS WHOLE WIDGET IS UPDATED ---
      bottomNavigationBar: Container(
        // Use a Container with BoxDecoration to create the shadow/border ABOVE
        decoration: BoxDecoration(
          // This color should match your scaffold's background or be white
          color: Theme.of(context).canvasColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, -2), // Negative 'dy' moves shadow UP
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) => _onTap(context, index),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          // Important: Make NavBar transparent so Container's decoration shows
          backgroundColor: Colors.transparent,
          elevation: 0, // We are handling elevation/shadow with the Container
          items: [
            BottomNavigationBarItem(
              icon: _buildNavItem(
                assetPath: 'assets/icons/Icons_bar/user-alt-1-svgrepo-com.svg',
                index: 0,
                hasBadge: false,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItem(
                assetPath: 'assets/icons/Icons_bar/bell-bing-svgrepo-com.svg',
                index: 1,
                hasBadge: true,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItem(
                assetPath:
                'assets/icons/Icons_bar/favorite-heart-like-love-alert-notification-svgrepo-com.svg',
                index: 2,
                hasBadge: false,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildNavItem(
                assetPath: 'assets/icons/Icons_bar/home-angle-2-svgrepo-com.svg',
                index: 3,
                hasBadge: true,
              ),
              label: '',
            ),
          ],
>>>>>>> development-
        ),
      ),
    );
  }
<<<<<<< HEAD
}//
=======
}
>>>>>>> development-
