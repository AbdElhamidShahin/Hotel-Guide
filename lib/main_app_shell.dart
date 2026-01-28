import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    required String iconAsset,
    required int index,
    required bool hasBadge,
  }) {
    final bool isSelected = navigationShell.currentIndex == index;

    final Color iconColor = isSelected
        ? AppColors.white
        : AppColors.ShadowPurple;
    final Color bgColor = isSelected
        ? AppColors.ShadowPurple
        : Colors.transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: SvgPicture.asset(
        iconAsset,
        height: 28.h,
        width: 28.w,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: navigationShell.currentIndex == 3 ? false : true,
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
                  iconAsset:
                      'assets/icons/Icons_bar/user-alt-1-svgrepo-com.svg',
                  index: 0,
                  hasBadge: false,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildNavItem(
                  iconAsset: 'assets/icons/Icons_bar/empty-wallet.svg',
                  index: 1,
                  hasBadge: true,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildNavItem(
                  iconAsset: 'assets/icons/Icons_bar/notification-favorite.svg',
                  index: 2,
                  hasBadge: false,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildNavItem(
                  iconAsset:
                      'assets/icons/Icons_bar/home-angle-2-svgrepo-com.svg',
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
