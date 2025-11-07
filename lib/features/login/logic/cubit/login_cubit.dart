import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_state.dart';
class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth auth;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginCubit(this.auth) : super(LoginInitial());

  Future<void> emitLoginState() async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());

    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          emit(LoginSuccess("تم تسجيل الدخول بنجاح ✅"));
        } else {
          emit(LoginEmailNotVerified(
            "من فضلك فعّل بريدك الإلكتروني أولاً.",
            userCredential.user!,
          ));
        }
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.message ?? "خطأ في تسجيل الدخول"));
    } catch (e) {
      emit(LoginError("حدث خطأ غير متوقع"));
    }
  }

  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
    emit(LoginSuccess("تم إرسال رابط تفعيل البريد الإلكتروني 📧"));
  }
}

// حالة جديدة:
class LoginEmailNotVerified extends LoginState {
  final String message;
  final User user;

  LoginEmailNotVerified(this.message, this.user);
}
