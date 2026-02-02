import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
      final response = await _loginRepository.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.user != null) {
        emit(LoginSuccess("تم تسجيل الدخول بنجاح. مرحباً بعودتك! ✨"));
      }
    } on AuthException catch (e) {
      // معالجة أخطاء سوبابيز
      String errorMessage = e.message;

      if (errorMessage.contains('Invalid login credentials')) {
        errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة. 🔑";
      } else if (errorMessage.contains('Email not confirmed')) {
        errorMessage = "يرجى تأكيد بريدك الإلكتروني أولاً. 📧";
      }

      emit(LoginError(errorMessage));
    } catch (e) {
      emit(LoginError("حدث خطأ غير متوقع. يرجى المحاولة لاحقاً. 🚧"));
    }
  }
}
