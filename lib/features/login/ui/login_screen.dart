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
import '../../../core/helpers/widget/custom_button.dart';
import '../../../core/router/routers.dart';
import '../logic/cubit/login_cubit.dart';
import '../logic/cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: context.read<LoginCubit>().formKey,

        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
              height: 0.25.sh,
                decoration: BoxDecoration(
                  color: const Color(0x83809FB2).withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF83809F).withOpacity(0.5),
                      blurRadius: 50,
                      spreadRadius: 20,
                      offset: const Offset(0, 0),
                    ),
                  ],
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
              ),

              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.h),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo/logo-light.png",
                        height: 150.r,
                        width: 150.r,
                      ),
                      SizedBox(height: 15.h),

                      Text(
                        "بوابتك لتجربة فندقية استثنائية",
                        style: textStyle30BoldPrimary.copyWith(
                          fontSize: 26.sp,
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 30.h),
                      BlocListener<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            showCustomSnackbar(
                              context,
                              ContentType.success,
                              'نجاح باهر! ✅',
                              state.message,
                            );
                            context.go(routes.homeScreen);
                          } else if (state is LoginError) {
                            showCustomSnackbar(
                              context,
                              ContentType.failure,
                              'خطأ في الدخول 🚨',
                              state.errorMessage,
                            );
                          } else if (state is LoginEmailNotVerified) {
                            showCustomSnackbar(
                              context,
                              ContentType.warning,
                              'تفعيل مطلوب 📧',
                              "من فضلك تحقق من بريدك الإلكتروني لإتمام عملية التفعيل.",
                            );
                          }
                        },
                        child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            final isLoading = state is LoginLoading;

                            return Align(
                              alignment: Alignment.topCenter,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const EmailAndPassword(),

                                    SizedBox(height: 30.h),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 56.h,
                                      child: CustomButton(
                                        text: 'تسجيل الدخول',
                                        onTap: isLoading
                                            ? null
                                            : () {
                                                context
                                                    .read<LoginCubit>()
                                                    .loginUser();
                                              },
                                      ),
                                    ),
                                    SizedBox(height: 20.h),

                                    DividerWithText(),
                                    SizedBox(height: 20.h),

                                    SocialLoginSection(),
                                    SizedBox(height: 30.h),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            context.go(routes.signUpScreen);
                                          },
                                          child: Text(
                                            'إنشاء حساب',
                                            style: textStyle16BoldWhite
                                                .copyWith(
                                                  color: AppColors.ShadowPurple,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          'لا تمتلك حساب؟',
                                          style: textStyle16RegularGray,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40.h),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

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
}
