import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/login/ui/widget/EmailAndPassword.dart';
import 'package:hotel_guide/features/login/ui/widget/divider_with_text.dart';
import 'package:hotel_guide/features/login/ui/widget/social_login_section.dart';
import '../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../core/router/routers.dart';
import '../logic/cubit/login_cubit.dart';
import '../logic/cubit/login_state.dart';

/// ✅ التغييرات:
///
/// ❌ حُذف: Form() + context.read<LoginCubit>().formKey من الـ Screen
///    السبب: الـ Form انتقل لـ EmailAndPassword widget
///
/// ❌ حُذف: CustomButton من الـ Screen
///    السبب: الـ Submit button انتقل لـ EmailAndPassword widget
///
/// ✅ الـ Screen دلوقتي بتعمل حاجة واحدة بس:
///    تسمع للـ states وترد بـ navigation أو snackbar
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: _handleState,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              _buildBackgroundGradient(),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo/logo-light.png',
                        height: 150.r,
                        width: 150.r,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'بوابتك لتجربة فندقية استثنائية',
                        style: textStyle30BoldPrimary.copyWith(fontSize: 26.sp),
                        maxLines: 1,
                      ),
                      SizedBox(height: 30.h),

                      // ✅ Form + Controllers + Submit كلهم جوه EmailAndPassword
                      const EmailAndPassword(),

                      SizedBox(height: 20.h),
                      DividerWithText(),
                      SizedBox(height: 20.h),
                      SocialLoginSection(),
                      SizedBox(height: 30.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => context.push(routes.signUpScreen),
                            child: Text(
                              'إنشاء حساب',
                              style: textStyle16BoldWhite.copyWith(
                                color: AppColors.ShadowPurple,
                              ),
                            ),
                          ),
                          Text('لا تمتلك حساب؟', style: textStyle16RegularGray),
                        ],
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleState(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      showCustomSnackbar(
        context,
        ContentType.success,
        'مرحباً بعودتك! ✅',
        'تم تسجيل الدخول بنجاح يا ${state.name}',
      );
      context.go(routes.homeScreen);
    } else if (state is LoginError) {
      showCustomSnackbar(
        context,
        ContentType.failure,
        'خطأ في الدخول 🚨',
        state.errorMessage,
      );
    }
  }

  Widget _buildBackgroundGradient() {
    return Container(
      width: double.infinity,
      height: 0.25.sh,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.0),
            const Color(0xFF83809F).withOpacity(0.6),
            Colors.white.withOpacity(0.0),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}
