import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_theme_data.dart';
import '../../theme/colors.dart';

class CustomAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbarWidget({
    super.key,
    required this.name,
    required this.onTap,
  });
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      // يقرأ لون خلفية الـ AppBar تلقائياً حسب الـ Theme الحالي
      color: Theme.of(context).appBarTheme.backgroundColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
      ),
      child: SizedBox(
        height: kToolbarHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              name,
              style: AppTextStyles.font22BoldPrimary(context).copyWith(
                fontWeight: FontWeight.w700,
                // التعديل هنا: يقرأ اللون الأساسي للـ Theme عشان يقلب معاك في الدارك تلقائي
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  // يتغير تلقائياً بين الأبيض والأسود حسب وضع الشاشة
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 28.sp,
                ),
                onPressed: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}