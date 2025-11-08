import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/login/ui/widget/EmailAndPassword.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'تسجيل الدخول',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.blueSoft,
              fontSize: 24,
            ),
          ),
        ),
        body: BlocListener<LoginCubit, LoginState>(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const EmailAndPassword(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'هل نسيت كلمة المرور؟',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blueSoft,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: CustomButton(
                            color: AppColors.blueSoft,
                            color2: AppColors.blueSoft,
                            text: isLoading
                                ? 'جاري التحميل...'
                                : 'تسجيل الدخول',
                            onTap: isLoading
                                ? null
                                : () {
                                    context.read<LoginCubit>().loginUser();
                                  },
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'حساب جديد',
                                style: TextStyle(
                                  color: AppColors.blueSoft,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'ليس لديك حساب؟',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 18,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
