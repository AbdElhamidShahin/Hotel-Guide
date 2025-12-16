import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/widget/custom_text_feild.dart';
import '../../logic/cubit/login_cubit.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormFeild(
          hintText: "البريد الإلكتروني",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "من فضلك أدخل بريدك الإلكتروني";
            } else if (!AppRegex.isEmailValid(value)) {
              return "البريد الإلكتروني المدخل غير صحيح. تأكد من الصيغة.";
            }
            return null;
          },
          controller: context.read<LoginCubit>().emailController,

          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(
              Icons.email_outlined,

              size: 30,
              color: AppColors.white.withOpacity(0.40),
            ),
          ),
        ),
        SizedBox(height: 30.h),
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
          controller: context.read<LoginCubit>().passwordController,
          hintText: "كلمة المرور",
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
                color: AppColors.white.withOpacity(0.40),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
