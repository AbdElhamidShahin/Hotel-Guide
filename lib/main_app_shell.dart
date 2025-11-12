import 'package:flutter/material.dart';
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
      child: iconWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
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
        ),
      ),
    );
  }
}