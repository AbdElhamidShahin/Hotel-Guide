import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/login/ui/widget/EmailAndPassword.dart';
import 'package:hotel_guide/features/login/ui/widget/divider_with_text.dart';
import 'package:hotel_guide/features/login/ui/widget/social_login_section.dart';
import '../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../core/router/routers.dart';
import '../logic/cubit/login_cubit.dart';
import '../logic/cubit/login_state.dart';

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
              _buildBackgroundGradient(context),
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
                      // Migrated from frozen font30BoldPrimary global.
                      Text(
                        'بوابتك لتجربة فندقية استثنائية',
                        style: AppTextStyles.font30BoldPrimary(context).copyWith(fontSize: 26.sp),
                        maxLines: 1,
                      ),
                      SizedBox(height: 30.h),

                      const EmailAndPassword(),

                      SizedBox(height: 20.h),
                      const DividerWithText(),
                      SizedBox(height: 20.h),
                      const SocialLoginSection(),
                      SizedBox(height: 30.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => context.push(routes.signUpScreen),
                            // Migrated from frozen font16BoldWhite global.
                            child: Text(
                              'إنشاء حساب',
                              style: AppTextStyles.font16BoldWhite(context).copyWith(
                                color: AppColors.ShadowPurple,
                              ),
                            ),
                          ),
                          // Migrated from frozen font16RegularMuted global.
                          Text('لا تمتلك حساب؟', style: AppTextStyles.font16RegularMuted(context)),
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

  /// Decorative top gradient. Fades from the scaffold background colour,
  /// through the brand purple accent, back to the scaffold background.
  /// Using scaffoldBackgroundColor (instead of a hardcoded Colors.white) at
  /// both ends means the gradient blends seamlessly with the page in both
  /// light and dark mode.
  Widget _buildBackgroundGradient(BuildContext context) {
    final bg = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      width: double.infinity,
      height: 0.25.sh,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            bg.withOpacity(0.0),
            const Color(0xFF83809F).withOpacity(0.6),
            bg.withOpacity(0.0),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}
