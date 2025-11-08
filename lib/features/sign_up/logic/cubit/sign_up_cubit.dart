import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_guide/features/sign_up/data/repo/sign_up_repo.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepostry _signUpRepostry;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignUpCubit(this._signUpRepostry) : super(SignUpInitial());

  Future<void> signUpUser() async {
    if (!formKey.currentState!.validate()) return;

    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      emit(SignUpError("كلمة المرور وتأكيدها غير متطابقين. ❌"));
      return;
    }

    emit(SignUpLoading());

    try {
      final userCredential = await _signUpRepostry.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
        confirmPasswordController.text.trim(),
      );

      final user = userCredential.user;

      if (user != null) {
        await user.sendEmailVerification();
        emit(SignUpVerificationRequired(user.email!));

      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Error Code: ${e.code}");
      String errorMessage = _mapFirebaseAuthErrorToArabic(e.code);
      emit(SignUpError(errorMessage));
    } catch (e) {
      print("General Error: $e");
      emit(SignUpError("حدث خطأ غير متوقع. نعتذر، يرجى المحاولة لاحقاً. 🚧"));
    }
  }

  String _mapFirebaseAuthErrorToArabic(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
        return "البريد الإلكتروني أو كلمة المرور غير صحيحة. 🔑";
      case 'user-not-found':
      case 'wrong-password':
        return "البريد الإلكتروني أو كلمة المرور غير صحيحة. 🔑";
      case 'email-already-in-use':
        return "البريد الإلكتروني مستخدم بالفعل. ⚠️";
      case 'invalid-email':
        return "صيغة البريد الإلكتروني غير صحيحة. 📧";
      case 'weak-password':
        return "كلمة المرور ضعيفة. اختر كلمة مرور أقوى 🔒";
      case 'network-request-failed':
        return "فشل الاتصال بالشبكة. تأكد من اتصالك بالإنترنت. 🌐";
      default:
        return "فشلت عملية التسجيل. يرجى المحاولة لاحقاً. 🚧";
    }
  }
}
