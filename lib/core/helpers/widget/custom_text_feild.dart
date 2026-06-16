import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_theme_data.dart';
import '../../theme/colors.dart';

class AppTextFormFeild extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backGroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  const AppTextFormFeild({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backGroundColor,
    this.inputTextStyle,
    this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              contentPadding ??
              EdgeInsets.symmetric(vertical: 24.w, horizontal: 11.h),
          enabledBorder:
              enabledBorder ??
              OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.ShadowPurple.withOpacity(0.9),
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
          focusedBorder:
              focusedBorder ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.accent,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.error, width: 1.3),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.error, width: 1.3),
            borderRadius: BorderRadius.circular(10),
          ),
          // Callers can still override hintStyle; fall back to the themed version.
          hintStyle: hintStyle ?? AppTextStyles.font14RegularNightfall(context),
          hintText: hintText,
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.info,
          // Caller-supplied background wins; otherwise transparent so the
          // InputDecorationTheme fillColor from AppThemeData applies.
          fillColor: backGroundColor ?? cs.surface,
          filled: true,
        ),
        obscureText: isObscureText ?? false,
        // Input text color reads from the live theme.
        style: AppTextStyles.font16MediumWhite(context).copyWith(
          color: cs.onSurface,
        ),
        validator: (value) {
          return validator(value);
        },
      ),
    );
  }
}
