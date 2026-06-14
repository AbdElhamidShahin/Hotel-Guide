import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme_data.dart';
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
              color: selected
                  ? AppColors.accent
                  : Theme.of(context).colorScheme.outline,
            ),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.done, size: 24, color: AppColors.ShadowPurple),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.font16BoldWhite(context).copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      cashBack,
                      style: AppTextStyles.font14RegularNightfall(context)
                          .copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withOpacity(0.6)
                                : Theme.of(context).colorScheme.surfaceTint,
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
