import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/repo/login_repostry.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepostry _loginRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginCubit(this._loginRepository) : super(LoginInitial());

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());

    try {
      final userCredential = await _loginRepository.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        emit(LoginSuccess("تم تسجيل الدخول بنجاح. مرحباً بعودتك! ✨"));
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Error Code: ${e.code}");

      String errorMessage = _mapFirebaseAuthErrorToArabic(e.code);
      emit(LoginError(errorMessage));
    } catch (e) {
      print("General Error: $e");
      emit(LoginError("حدث خطأ غير متوقع. نعتذر، يرجى المحاولة لاحقاً. 🚧"));
    }
  }

  String _mapFirebaseAuthErrorToArabic(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
        return "البريد الإلكتروني أو كلمة المرور غير صحيحة. 🔑";

      case 'user-not-found':
      case 'wrong-password':
        return "البريد الإلكتروني أو كلمة المرور غير صحيحة. 🔑";




      case 'network-request-failed':
        return "فشلت عملية تسجيل الدخول. تأكد من اتصالك بالإنترنت. 🌐";

      default:
        return "فشلت عملية تسجيل الدخول. يرجى المحاولة لاحقاً. 🚧";
    }
  }
}
