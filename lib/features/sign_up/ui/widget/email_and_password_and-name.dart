import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/widget/custom_text_feild.dart';
import '../../../../core/theme/app_theme.dart';

class EmailAndPasswordAndName extends StatefulWidget {
  const EmailAndPasswordAndName({super.key});

  @override
  State<EmailAndPasswordAndName> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPasswordAndName> {
  bool isObscureText = true;
  bool isObscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text("الإسم", style: textStyle16RegularGray),
        ),
        AppTextFormFeild(
          hintText: "abdo shahin",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "من فضلك أدخل الاسم";
            }
            return null;
          },
          controller: context.read<SignUpCubit>().nameController,
          suffixIcon: _buildSuffixIcon(Icons.person_outline_sharp),
        ),
        SizedBox(height: 16.h),
        _buildLabel("البريد الإلكتروني"),
        AppTextFormFeild(
          hintText: "examble@gmail.com",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "من فضلك أدخل بريدك الإلكتروني";
            } else if (!AppRegex.isEmailValid(value)) {
              return "البريد الإلكتروني المدخل غير صحيح. تأكد من الصيغة.";
            }
            return null;
          },
          controller: context.read<SignUpCubit>().emailController,

          suffixIcon: _buildSuffixIcon(Icons.email_outlined),
        ),
        SizedBox(height: 16.h),
        _buildLabel("كلمة المرور"),
        AppTextFormFeild(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "لا يمكن ترك كلمة المرور فارغة.";
            } else if (!AppRegex.hasMinLength(value)) {
              return "كلمة المرور يجب ألا تقل عن 8 أحرف.";
            } else if (!AppRegex.isPasswordValid(value)) {
              return "يجب أن تحتوي كلمة المرور على أحرف كبيرة، صغيرة، أرقام، ورمز خاص.";
            }
            return null;
          },
          controller: context.read<SignUpCubit>().passwordController,
          hintText: "******",
          isObscureText: isObscureText,
          suffixIcon: _buildPasswordIcon(
            isObscureText,
            () => setState(() => isObscureText = !isObscureText),
          ),
        ),
        SizedBox(height: 16.h),
        _buildLabel("تأكيد كلمة المرور"),
        AppTextFormFeild(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "لا يمكن ترك كلمة المرور فارغة.";
            } else if (!AppRegex.hasMinLength(value)) {
              return "كلمة المرور يجب ألا تقل عن 8 أحرف.";
            } else if (!AppRegex.isPasswordValid(value)) {
              return "يجب أن تحتوي كلمة المرور على أحرف كبيرة، صغيرة، أرقام، ورمز خاص.";
            }
            return null;
          },
          controller: context.read<SignUpCubit>().confirmPasswordController,
          hintText: "******",
          isObscureText: isObscureText2,
          suffixIcon: _buildPasswordIcon(
            isObscureText2,
            () => setState(() => isObscureText2 = !isObscureText2),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

Widget _buildLabel(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.h, top: 10.h),
    child: Text(text, style: textStyle16RegularGray.copyWith(fontSize: 14.sp)),
  );
}

Widget _buildSuffixIcon(IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    child: Icon(icon, size: 22.r, color: AppColors.primary),
  );
}

Widget _buildPasswordIcon(bool obscure, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Icon(
        obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        size: 22.r,
        color: AppColors.primary,
      ),
    ),
  );
}
