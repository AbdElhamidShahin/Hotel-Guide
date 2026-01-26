import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class PaymentTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final Widget? trailing;

  const PaymentTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? AppColors.Purple : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              if (trailing != null) ...[SizedBox(width: 8.w),
                trailing!],

              const Spacer(),
              Text(
                title,
                style: textStyle20RegularPrimary.copyWith(
                  color: AppColors.ShadowPurple,
                ),
              ),
              SizedBox(width: 12.w),
              Icon(
                selected
                    ? Icons.radio_button_checked_sharp
                    : Icons.radio_button_off,
                size: 22.sp,
                color: selected ? AppColors.Purple : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
