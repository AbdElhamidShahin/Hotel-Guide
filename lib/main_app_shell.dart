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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.navigationShell.currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    if (_pageController.hasClients &&
        _pageController.page?.round() != widget.navigationShell.currentIndex) {
      _pageController.jumpToPage(widget.navigationShell.currentIndex);
    }

    return PopScope(
      canPop: widget.navigationShell.currentIndex == 3 ? false : true,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        if (widget.navigationShell.currentIndex != 3) {
          _onTap(3);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            widget.navigationShell.goBranch(index);
          },
          children: [
            for (int i = 0; i < widget.navigationShell.route.branches.length; i++)
              _buildBranch(i),
          ],
        ),
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
            currentIndex: widget.navigationShell.currentIndex,
            onTap: _onTap,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _buildBottomItem('assets/icons/Icons_bar/user-alt-1-svgrepo-com.svg', 0),
              _buildBottomItem('assets/icons/Icons_bar/empty-wallet.svg', 1),
              _buildBottomItem('assets/icons/Icons_bar/notification-favorite.svg', 2),
              _buildBottomItem('assets/icons/Icons_bar/home-angle-2-svgrepo-com.svg', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBranch(int index) {
    return widget.navigationShell.currentIndex == index
        ? widget.navigationShell
        : const SizedBox.shrink();
  }

  BottomNavigationBarItem _buildBottomItem(String icon, int index) {
    return BottomNavigationBarItem(
      icon: _buildNavItem(iconAsset: icon, index: index),
      label: '',
    );
  }

  Widget _buildNavItem({required String iconAsset, required int index}) {
    final bool isSelected = widget.navigationShell.currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.ShadowPurple : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        iconAsset,
        height: 24.r,
        width: 24.r,
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.white : AppColors.ShadowPurple,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}