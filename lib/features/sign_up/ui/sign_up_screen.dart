import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
import '../../../core/helpers/widget/custom_button.dart';
import '../../../core/router/routers.dart';
import '../logic/cubit/sign_up_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF181201), Color(0xFFB25916)],
                stops: [0.48, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      Image.asset(
                        "assets/images/logo/logo.png",
                        width: 244.33.w,
                        height: 237.67.h,
                      ),

                      BlocListener<SignUpCubit, SignUpState>(
                        listener: (context, state) {
                          if (state is SignUpVerificationRequired) {
                            showCustomSnackbar(
                              context,
                              ContentType.warning,
                              'تحقق من بريدك 📧',
                              'تم إرسال كود التفعيل إلى ${state.email}',
                            );

                            context.go(
                              routes.verificationScreen,
                              extra: state.email,
                            );
                          } else if (state is SignUpSuccess) {
                            showCustomSnackbar(
                              context,
                              ContentType.success,
                              'نجاح باهر! ✅',
                              state.message,
                            );
                            context.go(routes.homeScreen);

                          } else if (state is SignUpError) {
                            showCustomSnackbar(
                              context,
                              ContentType.failure,
                              'خطأ في الدخول 🚨',
                              state.errorMessage,
                            );
                          } else if (state is SignUpEmailNotVerified) {
                            showCustomSnackbar(
                              context,
                              ContentType.warning,
                              'تفعيل مطلوب 📧',
                              "من فضلك تحقق من بريدك الإلكتروني لإتمام عملية التفعيل.",
                            );
                          }
                        },
                        child: BlocBuilder<SignUpCubit, SignUpState>(
                          builder: (context, state) {
                            final isLoading = state is SignUpLoading;

                            return Align(
                              alignment: Alignment.topCenter,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const EmailAndPasswordAndName(),

                                    SizedBox(height: 30),
                                    SizedBox(
                                      width: 260,
                                      height: 70,
                                      child: CustomButton(
                                        text: 'إنشاء حساب',
                                        onTap: isLoading
                                            ? null
                                            : () {
                                                context
                                                    .read<SignUpCubit>()
                                                    .signUpUser();
                                              },
                                      ),
                                    ),
                                    const SizedBox(height: 80),

                                    DividerWithText(),
                                    const SizedBox(height: 30),

                                    SocialLoginSection(),
                                    const SizedBox(height: 30),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            context.go(routes.loginScreen);
                                          },
                                          child: Text(
                                            'تسجيل دخول',
                                            style: textStyle20RegularWhite
                                                .copyWith(
                                                  color: AppColors.yellowGold,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          'لديك حساب بالفعل؟',
                                          style: textStyle20RegularWhite
                                              .copyWith(
                                                color: AppColors.white
                                                    .withOpacity(0.60),
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
