import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';
class PaymentTitle extends StatelessWidget {
  const PaymentTitle({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.isCard = false,
    this.isLoading = false,
  });

  final String title;
  final bool isSelected;
  final VoidCallback? onTap;
  final String? icon;
  final bool isCard;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            _RadioIndicator(isSelected: isSelected),
            SizedBox(width: 12.w),
            Text(
              title,
              style: AppTextStyles.font16RegularMuted(context).copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            if (isLoading)
              SizedBox(
                width: 20.r,
                height: 20.r,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            else if (isCard)
              Row(
                children: [
                  SvgPicture.asset('assets/icons/MasterCard.svg', width: 30.w),
                  SizedBox(width: 8.w),
                  SvgPicture.asset('assets/icons/Visa.svg', width: 30.w),
                ],
              )
            else if (icon != null)
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.ShadowPurple.withOpacity(0.1),
                  ),
                  child: SvgPicture.asset(icon!, width: 20.w),
                ),
          ],
        ),
      ),
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.r,
      height: 20.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary),
        color: isSelected ? AppColors.primary : Colors.transparent,
      ),
      child: isSelected
          ? Icon(Icons.check, size: 12.r, color: Colors.white)
          : null,
    );
  }
}