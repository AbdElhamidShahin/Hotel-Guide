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

  Widget _buildNavItem({
    required String defaultAsset,
    required String selectedAsset,
    required int index,
    required bool hasBadge,
  }) {
    final bool isSelected = navigationShell.currentIndex == index;

    final Color iconColor = isSelected ? AppColors.orangeGold : Colors.grey.shade600;



    Widget iconWidget = SvgPicture.asset(
      isSelected ? selectedAsset : defaultAsset,
      height: 32,
      width: 32,
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: iconWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: navigationShell.currentIndex == 3
          ? false
          : true,
      onPopInvoked: (bool didPop) {
        if (didPop) return;

        if (navigationShell.currentIndex != 3) {
          navigationShell.goBranch(3);
        } else {
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
  //
//
}