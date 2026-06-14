import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme_data.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.name,
    required this.onPressed,
  });
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // Always dark navy — brand action button, same in both themes.
          backgroundColor: const Color(0xFF2C2C3E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        // Migrated from frozen font22BoldPrimary global.
        // Always white — text on dark navy button.
        child: Text(name, style: AppTextStyles.font22BoldPrimary(context)),
      ),
    );
  }
}
