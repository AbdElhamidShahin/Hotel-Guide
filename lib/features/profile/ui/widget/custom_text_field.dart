import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';

class Customtextfeild extends StatelessWidget {
  const Customtextfeild({
    super.key,
    required this.hintText,
    required this.label,
    this.onChanged,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: AppTextStyles.font12BoldBlack(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            keyboardType: keyboardType,
            textAlign: TextAlign.right,
            // Input text colour from live theme.
            style: TextStyle(
              color: cs.onSurface,
              fontSize: 16.sp,
              fontFamily: 'Cairo',
            ),
            decoration: InputDecoration(
              filled: true,
              // surface = white in light, dark card in dark mode.
              fillColor: cs.surface,
              hintText: hintText,
              // Migrated from frozen font15MediumGray global.
              hintStyle: AppTextStyles.font15MediumGray(context),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 16.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: cs.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: cs.outline,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.secondary,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: cs.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: cs.error, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
