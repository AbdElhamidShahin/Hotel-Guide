import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/widget/custom_text_feild.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../logic/cubit/sign_up_state.dart';

class EmailAndPasswordAndName extends StatefulWidget {
  const EmailAndPasswordAndName({super.key});

  @override
  State<EmailAndPasswordAndName> createState() =>
      _EmailAndPasswordAndNameState();
}

class _EmailAndPasswordAndNameState extends State<EmailAndPasswordAndName> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<SignUpCubit>().signUpUser(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildLabel(context, 'الإسم'),
          AppTextFormFeild(
            hintText: 'abdo shahin',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'من فضلك أدخل الاسم';
              }
              return null;
            },
            suffixIcon: _buildSuffixIcon(Icons.person_outline_sharp, context),
          ),
          SizedBox(height: 16.h),
          _buildLabel(context, 'البريد الإلكتروني'),
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
            suffixIcon: _buildSuffixIcon(Icons.email_outlined, context),
          ),
          SizedBox(height: 16.h),
          _buildLabel(context, 'كلمة المرور'),
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
              if (!AppRegex.isPasswordValid(value)) {
                return 'يجب أن تحتوي على أحرف كبيرة وصغيرة وأرقام ورمز خاص';
              }
              return null;
            },
            suffixIcon: _buildPasswordIcon(
              _isPasswordHidden,
              () => setState(() => _isPasswordHidden = !_isPasswordHidden),
            ),
          ),
          SizedBox(height: 16.h),
          _buildLabel(context, 'تأكيد كلمة المرور'),
          AppTextFormFeild(
            hintText: '******',
            controller: _confirmPasswordController,
            isObscureText: _isConfirmPasswordHidden,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'لا يمكن ترك تأكيد كلمة المرور فارغاً';
              }
              if (value.trim() != _passwordController.text.trim()) {
                return 'كلمة المرور وتأكيدها غير متطابقين ❌';
              }
              return null;
            },
            suffixIcon: _buildPasswordIcon(
              _isConfirmPasswordHidden,
              () => setState(
                () => _isConfirmPasswordHidden = !_isConfirmPasswordHidden,
              ),
            ),
          ),
          SizedBox(height: 20.h),

          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: _onSubmit,
                  child: Text(
                    'إنشاء حساب',
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

Widget _buildLabel(BuildContext context, String text) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Padding(
    padding: EdgeInsets.only(bottom: 6.h, top: 10.h),
    child: Text(
      text,
      style: AppTextStyles.font16RegularMuted(context).copyWith(
        fontSize: 14.sp,
        color: isDark ? Colors.white : AppColors.primary,
      ),
    ),
  );
}

Widget _buildSuffixIcon(IconData icon, context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    child: Icon(
      icon,
      size: 22.r,
      color: isDark ? Colors.white70 : AppColors.primary,
    ),
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
