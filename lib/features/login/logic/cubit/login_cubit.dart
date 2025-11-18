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

      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = "لا يوجد حساب بهذا البريد الإلكتروني. سجّل الآن! 📝";
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة. 🔑";
      } else if (e.code == 'network-request-failed') {
        errorMessage = "فشلت عملية تسجيل الدخول. تأكد من اتصالك بالإنترنت. 🌐";
      } else {
        errorMessage = "حدث خطأ غير متوقع. يرجى المحاولة لاحقاً. 🚧";
      }

      emit(LoginError(errorMessage));
    } catch (e) {
      print("General Error: $e");
      emit(LoginError("حدث خطأ غير متوقع. نعتذر، يرجى المحاولة لاحقاً. 🚧"));
    }
  }

}
