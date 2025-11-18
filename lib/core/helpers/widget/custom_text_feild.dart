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
              EdgeInsets.symmetric(vertical: 16, horizontal: 11),
          enabledBorder:
              enabledBorder ??
              OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.white.withOpacity(0.26),
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
          focusedBorder:
              focusedBorder ??
              OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.blueSoft, width: 1.3),

                borderRadius: BorderRadius.circular(10),
              ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.3),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.3),
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: hintStyle ?? textStyle20RegularWhite,
          hintText: "${hintText}",
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.blueSoft,

          fillColor: backGroundColor ?? Colors.transparent,
          filled: true,
        ),
        obscureText: isObscureText ?? false,

        style: textStyle16mediumWhite,
        validator: (value) {
          return validator(value);
        },
      ),
    );
  }
}
