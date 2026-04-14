import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/login/ui/widget/divider_with_text.dart';
import 'package:hotel_guide/features/login/ui/widget/social_login_section.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:hotel_guide/features/sign_up/ui/widget/email_and_password_and-name.dart';
import '../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../core/router/routers.dart';
import '../logic/cubit/sign_up_state.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: _handleState,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(color: Colors.transparent),
              ),
              _buildBackgroundGradient(),

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
                      Text(
                        'بوابتك لتجربة فندقية استثنائية',
                        style: font30BoldPrimary.copyWith(fontSize: 26.sp),
                        maxLines: 1,
                      ),
                      SizedBox(height: 20.h),

                      const EmailAndPasswordAndName(),

                      SizedBox(height: 20.h),
                      DividerWithText(),
                      SizedBox(height: 20.h),
                      SocialLoginSection(),
                      SizedBox(height: 30.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => context.push(routes.loginScreen),
                            child: Text(
                              'تسجيل دخول',
                              style: font16BoldWhite.copyWith(
                                color: AppColors.ShadowPurple,
                              ),
                            ),
                          ),
                          Text(
                            'لديك حساب بالفعل؟',
                            style: font16RegularMuted,
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
