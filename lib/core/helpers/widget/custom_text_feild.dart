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
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true, //defult pading
        contentPadding:
        contentPadding ??
            EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        enabledBorder:
        enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gray, width: 1.3),
              borderRadius: BorderRadius.circular(16),
            ),
        focusedBorder:
        focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.blueSoft, width: 1.3),

              borderRadius: BorderRadius.circular(16),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(16),
        ),
        hintStyle:
        hintStyle ?? textStyle20RegularWhite,
        hintText: "${hintText}",
        suffixIcon: suffixIcon,
        suffixIconColor: AppColors.blueSoft,

        fillColor: backGroundColor ?? AppColors.orangeDark,
        filled: true,
      ),
      obscureText: isObscureText ?? false, //تظهر الكلام كنجوم

      style: textStyle20RegularWhite.copyWith(color: AppColors.gray),
      validator: (value) {
        return validator(value);
      },
    );
  }
}
