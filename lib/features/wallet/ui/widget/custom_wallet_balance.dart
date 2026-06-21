import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../../core/helpers/custom_user_avatar.dart';
import '../../../../core/helpers/local_storage_account.dart';
import '../../../../core/network/model/profile_model.dart';
import '../../../../core/theme/app_theme.dart';

class CustomWalletBalance extends StatefulWidget {
  final Function(String) onTabChanged;
  CustomWalletBalance({
    super.key,
    required this.onTabChanged,
    required this.profileModel,
    this.name,
    this.imageUrl,
    this.currentImageFile,
  });
  final UserProfileModel profileModel;
  final String? name;
  final String? imageUrl;
  final File? currentImageFile;
  @override
  State<CustomWalletBalance> createState() => _CustomWalletBalanceState();
}

class _CustomWalletBalanceState extends State<CustomWalletBalance> {
  String? name;
  String? image;
  String _activeTab = 'history';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await UserDataManager.loadUserData();
    if (mounted) {
      setState(() {
        name = userData['name'] ?? widget.name;
        image = userData['image'] ?? widget.imageUrl;
      });
    }
  }

  void _switchTab(String tab) {
    setState(() => _activeTab = tab);
    widget.onTabChanged(tab);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.r),

                    border: Border.all(color: AppColors.colorText),
                  ),
                  child: CustomUserAvatar(
                    radius: 80,
                    currentImageFile: widget.currentImageFile,
                    imagePathOrUrl: image,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              widget.profileModel.fullName,
              // ✅ Fix #4: غيّرنا font23SemiBoldBlack (مجمّدة — لا تتغير مع Dark Mode)
              // إلى AppTextStyles.font23SemiBoldBlack(context) اللي بتقرأ من الـ Theme.
              // على سطح primary (بنفسجي) النص دايماً أبيض، فـ copyWith لازم يفضل.
              style: AppTextStyles.font23SemiBoldBlack(
                context,
              ).copyWith(color: Colors.white),
            ),
            SizedBox(height: 12.h),
            Container(
              width: 170,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.r),
                color: AppColors.ShadowPurple,
              ),
              child: Row(
                children: [
                  Text(
                    "ID  ",
                    style: font22RegularWhite.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                  Text(
                    widget.profileModel.id.length > 8
                        ? widget.profileModel.id.substring(0, 8).toUpperCase()
                        : widget.profileModel.id,
                    style: font20BoldShadowPurple.copyWith(
                      color: AppColors.textWhite.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.PurplePrimary,
                ),
                child: Column(
                  children: [
                    Text(
                      "الرصيد الحالي",
                      style: font16RegularMuted.copyWith(
                        color: AppColors.textWhite,
                      ),
                    ),

                    Text(
                      "${widget.profileModel.walletBalance}",
                      style: font36BoldWhite,
                    ),

                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TabButton(
                          icon: 'assets/icons/refresh-circle.svg',
                          label: 'سجل المعاملات',
                          isActive: _activeTab == 'history',
                          onTap: () => _switchTab('history'),
                        ),
                        Container(
                          height: 32.h,
                          color: Colors.white,
                          width: 1.5,
                        ),
                        _TabButton(
                          icon: 'assets/icons/money-recive.svg',
                          label: 'الإسترداد',
                          isActive: _activeTab == 'refund',
                          onTap: () => _switchTab('refund'),
                        ),
                        Container(
                          height: 32.h,
                          color: Colors.white,
                          width: 1.5,
                        ),
                        _TabButton(
                          icon: 'assets/icons/empty-wallet-add.svg',
                          label: 'شحن رصيد',
                          isActive: _activeTab == 'topup',
                          onTap: () => _switchTab('topup'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });
  final String icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            // ignore: deprecated_member_use
            color: isActive ? AppColors.AccentsPurple : AppColors.textWhite,
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            style: font16RegularMuted.copyWith(
              color: isActive ? AppColors.AccentsPurple : AppColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }
}
