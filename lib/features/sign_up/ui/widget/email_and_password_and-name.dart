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

          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(
              Icons.person_outline_sharp,

              size: 30,
              color: AppColors.primary,
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text("البريد الإلكتروني", style: textStyle16RegularGray),
        ),
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

          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(
              Icons.email_outlined,

              size: 30,
              color: AppColors.primary,
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text("كلمة المرور", style: textStyle16RegularGray),
        ),
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
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscureText = !isObscureText;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Icon(
                isObscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 30,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text("تأكيد كلمة المرور", style: textStyle16RegularGray),
        ),
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
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscureText2 = !isObscureText2;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Icon(
                isObscureText2
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 30,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
