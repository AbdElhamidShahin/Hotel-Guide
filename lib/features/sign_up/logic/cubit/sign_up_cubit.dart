import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/repo/sign_up_repo.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepository _signUpRepository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignUpCubit(this._signUpRepository) : super(SignUpInitial());

  Future<void> signUpUser() async {
    if (!formKey.currentState!.validate()) return;

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      emit(SignUpError("كلمة المرور وتأكيدها غير متطابقين. ❌"));
      return;
    }

    emit(SignUpLoading());

    try {
      final response = await _signUpRepository.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
      );

      if (response.user != null) {
        if (response.session == null) {
          emit(SignUpEmailNotVerified());
        } else {
          await Future.delayed(const Duration(seconds: 1));
          emit(SignUpSuccess("تم إنشاء الحساب بنجاح!"));
        }
      }
    } on AuthException catch (e) {
      print("Supabase Error: ${e.message}");
      emit(SignUpError(_mapSupabaseError(e.message)));
    } catch (e) {
      print("General Error: $e");
      emit(SignUpError("حدث خطأ غير متوقع. حاول مرة أخرى. 🚧"));
    }
  }

  String _mapSupabaseError(String message) {
    message = message.toLowerCase();
    if (message.contains("user already registered") ||
        message.contains("already exists")) {
      return "البريد الإلكتروني مستخدم بالفعل. ⚠️";
    } else if (message.contains("password should be at least")) {
      return "كلمة المرور يجب أن تكون 6 أحرف على الأقل. 🔒";
    } else if (message.contains("invalid email")) {
      return "صيغة البريد الإلكتروني غير صحيحة. 📧";
    } else if (message.contains("network")) {
      return "مشكلة في الاتصال بالإنترنت. 🌐";
    }
    return "فشل إنشاء الحساب: $message";
  }
}
