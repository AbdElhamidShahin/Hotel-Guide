import 'dart:ui';
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
import '../../../core/helpers/local_storage_account.dart';
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15.0,
                  sigmaY: 15.0,
                ), // درجة التغبيش
                child: Container(color: Colors.transparent),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: const Color(0x83809FB2).withOpacity(0.3),
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          SizedBox(height: 24.h),
                          Image.asset(
                            "assets/images/logo/logo-light.png",
                            height: 173.h,
                            width: 173.w,
                          ),
                          SizedBox(height: 20.h),

                          Text(
                            "بوابتك لتجربة فندقية استثنائية",
                            style: textStyle30BoldPrimary.copyWith(
                              fontSize: 26.sp,
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(height: 20.h),
                          BlocListener<SignUpCubit, SignUpState>(
                            listener: (context, state) async {
                              if (state is SignUpSuccess) {
                                final name = context
                                    .read<SignUpCubit>()
                                    .nameController
                                    .text;
                                final email = context
                                    .read<SignUpCubit>()
                                    .emailController
                                    .text;

                                await UserDataManager.saveUserData(
                                  name: name,
                                  email: email,
                                  phone: '',
                                );
                                showCustomSnackbar(
                                  context,
                                  ContentType.success,
                                  'نجاح باهر! ✅',
                                  state.message,
                                );
                                context.go(
                                  routes.homeScreen,
                                  extra: {'name': name},
                                );
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const EmailAndPasswordAndName(),

                                        SizedBox(height: 30.h),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 63.h,
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
                                        SizedBox(height: 16.h),

                                        DividerWithText(),
                                        SizedBox(height: 20.h),

                                        SocialLoginSection(),
                                        SizedBox(height: 50.h),

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
                                                style: textStyle16BoldWhite
                                                    .copyWith(
                                                      color: AppColors
                                                          .ShadowPurple,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              'لديك حساب بالفعل؟',
                                              style: textStyle16RegularGray,
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 50.h),
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
            ],
          ),
        ),
      ),
    );
  }
}
