import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/widget/custom_text_feild.dart';
import '../../../../core/theme/app_theme.dart';
import '../../logic/cubit/login_cubit.dart';
import '../../logic/cubit/login_state.dart';

/// ✅ التغييرات:
///
/// ❌ قبل: context.read<LoginCubit>().emailController ← من الـ Cubit
/// ✅ بعد: controllers موجودين هنا في الـ State
///
/// ❌ قبل: FormKey في الـ Cubit
/// ✅ بعد: FormKey هنا في الـ State
///
/// ✅ الـ Submit button انتقل هنا عشان يكون قريب من الـ FormKey
class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  // ✅ Controllers هنا — في الـ State مش في الـ Cubit
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordHidden = true;

  // ✅ Dispose — مهم عشان مفيش memory leak
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    // ✅ بنبعت القيم للـ Cubit كـ parameters — مش بنديه controllers
    context.read<LoginCubit>().loginUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('البريد الإلكتروني', style: textStyle16RegularGray),
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
                color: AppColors.primary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
            child: Text('كلمة المرور', style: textStyle16RegularGray),
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
              onTap: () => setState(() => _isPasswordHidden = !_isPasswordHidden),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(
                  _isPasswordHidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 24.r,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),

          // ✅ Submit button هنا جنب الـ FormKey
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                final isLoading = state is LoginLoading;
                return ElevatedButton(
                  onPressed: isLoading ? null : _onSubmit,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('تسجيل الدخول'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
