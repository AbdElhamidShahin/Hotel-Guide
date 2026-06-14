import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import '../../../../core/helpers/custom_user_avatar.dart';
import '../../../../core/helpers/local_storage_account.dart';
import '../../../../core/network/model/profile_model.dart';

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
    if (mounted)
      setState(() {
        name = userData['name'] ?? widget.name;
        image = userData['image'] ?? widget.imageUrl;
      });
  }

  void _switchTab(String tab) {
    setState(() => _activeTab = tab);
    widget.onTabChanged(tab);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: cs.primary,
        ),
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.r),
                border: Border.all(color: cs.onPrimary),
              ),
              child: CustomUserAvatar(
                radius: 80,
                currentImageFile: widget.currentImageFile,
                imagePathOrUrl: image,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              widget.profileModel.fullName,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12.h),
            Container(
              width: 170,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.r),
                color: cs.primaryContainer,
              ),
              child: Row(
                children: [
                  Text(
                    'ID  ',
                    style: AppTextStyles.font22RegularWhite(
                      context,
                    ).copyWith(color: cs.onPrimaryContainer),
                  ),
                  Text(
                    widget.profileModel.id.length > 8
                        ? widget.profileModel.id.substring(0, 8).toUpperCase()
                        : widget.profileModel.id,
                    style: AppTextStyles.font20BoldShadowPurple(
                      context,
                    ).copyWith(color: cs.onPrimaryContainer.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: cs.surfaceContainerHighest,
                ),
                child: Column(
                  children: [
                    Text(
                      'الرصيد الحالي',
                      style: AppTextStyles.font16RegularMuted(
                        context,
                      ).copyWith(color: cs.onSurfaceVariant),
                    ),
                    Text(
                      '${widget.profileModel.walletBalance}',
                      style: AppTextStyles.font36BoldWhite(
                        context,
                      ).copyWith(color: cs.onSurface),
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
                          color: cs.onSurfaceVariant,
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
                          color: cs.onSurfaceVariant,
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
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              isActive ? cs.primary : cs.onSurfaceVariant,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            style: AppTextStyles.font16RegularMuted(
              context,
            ).copyWith(color: isActive ? cs.primary : cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
