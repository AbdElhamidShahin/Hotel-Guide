import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/login/ui/widget/divider_with_text.dart';
import 'package:hotel_guide/features/login/ui/widget/social_login_section.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:hotel_guide/features/sign_up/ui/widget/email_and_password_and-name.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../core/router/routers.dart';
import '../logic/cubit/sign_up_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: _handleState,
      child: Scaffold(
        // Inherits scaffoldBackgroundColor from AppThemeData automatically.
        body: SingleChildScrollView(
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(color: Colors.transparent),
              ),
              _buildBackgroundGradient(context),

              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Image.asset(
                        'assets/images/logo/logo-light.png',
                        height: 150.h,
                        width: 150.w,
                      ),
                      SizedBox(height: 15.h),
                      // Migrated from frozen font30BoldPrimary global.
                      Text(
                        'بوابتك لتجربة فندقية استثنائية',
                        style: AppTextStyles.font30BoldPrimary(context).copyWith(fontSize: 26.sp),
                        maxLines: 1,
                      ),
                      SizedBox(height: 20.h),

                      const EmailAndPasswordAndName(),

                      SizedBox(height: 20.h),
                      const DividerWithText(),
                      SizedBox(height: 20.h),
                      const SocialLoginSection(),
                      SizedBox(height: 30.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => context.push(routes.loginScreen),
                            // Migrated from frozen font16BoldWhite global.
                            child: Text(
                              'تسجيل دخول',
                              style: AppTextStyles.font16BoldWhite(context).copyWith(
                                color: AppColors.ShadowPurple,
                              ),
                            ),
                          ),
                          // Migrated from frozen font16RegularMuted global.
                          Text(
                            'لديك حساب بالفعل؟',
                            style: AppTextStyles.font16RegularMuted(context),
                            textDirection: TextDirection.rtl,
                          ),
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

  void _handleState(BuildContext context, SignUpState state) {
    if (state is SignUpSuccess) {
      showCustomSnackbar(
        context,
        ContentType.success,
        'مرحباً بك! ✅',
        'تم إنشاء حسابك بنجاح يا ${state.name}',
      );
      context.go(routes.homeScreen);
    } else if (state is SignUpVerificationRequired) {
      showCustomSnackbar(
        context,
        ContentType.warning,
        'تفعيل مطلوب 📧',
        'تم إرسال رسالة تأكيد لـ ${state.email}',
      );
    } else if (state is SignUpError) {
      showCustomSnackbar(
        context,
        ContentType.failure,
        'خطأ 🚨',
        state.errorMessage,
      );
    }
  }

  /// Decorative top gradient. Fades from the scaffold background colour,
  /// through the brand purple accent, back to the scaffold background —
  /// blends seamlessly in both light and dark mode.
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
