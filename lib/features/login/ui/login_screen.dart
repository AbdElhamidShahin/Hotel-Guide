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

        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.4, 1.0],

              colors: [Color(0xFF000000), Color(0xFF51526C)],
            ),
          ),

          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.h),
                  child: Column(
                    children: [
                      Image.asset("assets/images/logo/logo.png"),

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
                                      width: 260.w,
                                      height: 70.h,
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
                                    SizedBox(height: 42.h),

                                    DividerWithText(),
                                    const SizedBox(height: 30),

                                    SocialLoginSection(),
                                    SizedBox(height: 33.h),

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
                                            style: textStyle20RegularWhite
                                                .copyWith(
                                                  color: AppColors.white,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          'لا تمتلك حساب؟',
                                          style: textStyle20RegularWhite
                                              .copyWith(
                                                color: AppColors.white
                                                    .withOpacity(0.60),
                                              ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                   SizedBox(height: 150.h,) ],
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
