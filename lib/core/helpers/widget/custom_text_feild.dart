import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_theme.dart';
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
                borderSide: BorderSide(
                  color: AppColors.RoyalPurple,
                  width: 1.3,
                ),

                borderRadius: BorderRadius.circular(10),
              ),
          errorBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: AppColors.red, width: 1.3),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: AppColors.red, width: 1.3),
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: hintStyle ?? textStyle14RegularNightfall,
          hintText: "${hintText}",
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.blueSoft,

          fillColor: backGroundColor ?? Colors.transparent,
          filled: true,
        ),
        obscureText: isObscureText ?? false,

        style: textStyle16mediumWhite.copyWith(color: AppColors.primary),
        validator: (value) {
          return validator(value);
        },
      ),
    );
  }
}
