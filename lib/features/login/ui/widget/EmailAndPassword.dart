import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/widget/custom_text_feild.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../logic/cubit/login_cubit.dart';
import '../../logic/cubit/login_state.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginCubit>().loginUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            // Migrated from frozen font16RegularMuted global.
            child: Text(
              'البريد الإلكتروني',
              style: AppTextStyles.font16RegularMuted(
                context,
              ).copyWith(color: isDark ? Colors.white : colorScheme.primary),
            ),
          ),
          AppTextFormFeild(
            hintText: 'example@gmail.com',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'من فضلك أدخل بريدك الإلكتروني';
              }
              if (!AppRegex.isEmailValid(value)) {
                return 'البريد الإلكتروني غير صحيح';
              }
              return null;
            },
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Icon(
                Icons.email_outlined,
                size: 24.r,
                color: isDark ? Colors.white70 : colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
            child: Text(
              'كلمة المرور',
              style: AppTextStyles.font16RegularMuted(context).copyWith(
                color: isDark
                    ? Colors.white
                    : colorScheme.primary, // أبيض في الدارك
              ),
            ),
          ),
          AppTextFormFeild(
            hintText: '******',
            controller: _passwordController,
            isObscureText: _isPasswordHidden,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'لا يمكن ترك كلمة المرور فارغة';
              }
              if (!AppRegex.hasMinLength(value)) {
                return 'كلمة المرور يجب ألا تقل عن 8 أحرف';
              }
              return null;
            },
            suffixIcon: GestureDetector(
              onTap: () =>
                  setState(() => _isPasswordHidden = !_isPasswordHidden),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(
                  _isPasswordHidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 24.r,
                  color: isDark ? Colors.white70 : colorScheme.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                final isLoading = state is LoginLoading;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: isLoading ? null : _onSubmit,
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
