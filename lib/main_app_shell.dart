import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class MainAppShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainAppShell({super.key, required this.navigationShell});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}


class _MainAppShellState extends State<MainAppShell> {
  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.navigationShell.currentIndex == 3,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (widget.navigationShell.currentIndex != 3) {
          _onTap(3);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: widget.navigationShell,

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: widget.navigationShell.currentIndex,
            onTap: _onTap,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _buildBottomItem(
                'assets/icons/Icons_bar/user-alt-1-svgrepo-com.svg',
                0,
              ),
              _buildBottomItem('assets/icons/Icons_bar/empty-wallet.svg', 1),
              _buildBottomItem(
                'assets/icons/Icons_bar/notification-favorite.svg',
                2,
              ),
              _buildBottomItem(
                'assets/icons/Icons_bar/home-angle-2-svgrepo-com.svg',
                3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomItem(String icon, int index) {
    final bool isSelected = widget.navigationShell.currentIndex == index;
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.ShadowPurple : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          height: 24.r,
          width: 24.r,
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : AppColors.ShadowPurple,
            BlendMode.srcIn,
          ),
        ),
      ),
      label: '',
    );
  }
}
