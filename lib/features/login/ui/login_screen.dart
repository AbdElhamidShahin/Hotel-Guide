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
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF181201), Color(0xFFB25916)],
                stops: [0.55, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo/logo.png",
                        width: 244.33,
                        height: 237.67,

                      ),

                      BlocListener<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            showCustomSnackbar(
                              context,
                              ContentType.success,
                              'نجاح باهر! ✅',
                              state.message,
                            );
                            context.go(routes.onBoardingScreen);
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const EmailAndPassword(),

                                    SizedBox(height: 30),
                                    SizedBox(
                                      width: 260,
                                      height: 70,
                                      child: CustomButton(
                                        text: 'التالي',
                                        onTap: isLoading
                                            ? null
                                            : () {
                                                context
                                                    .read<LoginCubit>()
                                                    .loginUser();
                                              },
                                      ),
                                    ),
                                    const SizedBox(height: 48),

                                    DividerWithText(),
                                    const SizedBox(height: 30),

                                    SocialLoginSection(),
                                    const SizedBox(height: 30),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {



                                            context.go(routes.signUpScreen);

                                          },
                                          child: Text(
                                            'إنشاء حساب',
                                            style: textStyle20RegularWhite.copyWith(
                                              color: AppColors.yellowGold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'لا تمتلك حساب؟',
                                          style: textStyle20RegularWhite.copyWith(
                                            color: AppColors.white.withOpacity(
                                              0.60,
                                            ),
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 180),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
