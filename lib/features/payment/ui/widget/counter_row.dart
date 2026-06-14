import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';
class CounterRow extends StatelessWidget {
  final String title;
  final int value;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CounterRow({
    super.key,
    required this.title,
    required this.value,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.font22BoldPrimary(context).copyWith(
              color: AppColors.ShadowPurple,
            ),
          ),
          Row(
            children: [
              _circleBtn(Icons.add, onAdd, AppColors.primary, AppColors.textWhite),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              _circleBtn(
                Icons.remove,
                onRemove,
                AppColors.primary.withOpacity(0.1),
                AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(
      IconData icon,
      VoidCallback onTap,
      Color color,
      Color colorIcon,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color,
        child: Icon(icon, size: 24, color: colorIcon),
      ),
    );
  }
}