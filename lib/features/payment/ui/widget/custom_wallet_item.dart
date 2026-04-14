import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

class CustomWalletItem extends StatelessWidget {
  const CustomWalletItem({
    super.key,
    required this.image,
    required this.title,
    required this.cashBack,
    required this.onTap,
    required this.selected,
  });

  final String image;
  final String title;
  final String cashBack;
  final bool selected;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? AppColors.accent : Colors.transparent,
            ),
            color: AppColors.textWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.done, size: 24, color: AppColors.ShadowPurple),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: textStyle16BoldWhite.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      cashBack,
                      style: textStyle14RegularNightfall.copyWith(
                        color: AppColors.Grayscale,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(200.r),
                  child: Image.asset(
                    image,
                    height: 38.h,
                    width: 38.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
