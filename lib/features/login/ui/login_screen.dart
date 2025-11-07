import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/routers.dart';
import '../logic/cubit/login_cubit.dart';
import '../logic/cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is LoginLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(child: CircularProgressIndicator()),
                  );
                }
              },              builder: (context, state) {
                final cubit = context.read<LoginCubit>();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: cubit.emailController,
                      decoration: const InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل البريد الإلكتروني';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: cubit.passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'كلمة المرور',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل كلمة المرور';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          context.go(routes.onBoardingScreen);
                        },                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        context.go(routes.onBoardingScreen);
                      },
                      child: const Text(
                        'ليس لديك حساب؟ إنشاء حساب جديد',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                );
              },

            )

          ),
        ),
      ),
    );
  }
}
