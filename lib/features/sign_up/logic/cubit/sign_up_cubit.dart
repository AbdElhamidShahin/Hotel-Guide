import 'dart:async'; // ضروري جداً للـ StreamSubscription
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/helpers/local_storage_account.dart';
import '../../data/repo/sign_up_repo.dart';
import 'sign_up_state.dart';
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepository _signUpRepository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  StreamSubscription<AuthState>? _authSubscription;

  SignUpCubit(this._signUpRepository) : super(SignUpInitial()) {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final session = data.session;
      if (session != null && data.event == AuthChangeEvent.signedIn) {
        final user = session.user;

        final String name = user.userMetadata?['full_name'] ?? "مستخدم جديد";
        final String imageUrl = user.userMetadata?['avatar_url'] ?? ""; // سحب الصورة هنا
        final String email = user.email ?? "";

        await UserDataManager.saveUserData(
          name: name,
          email: email,
          image: imageUrl,
          phone: '',
        );

        if (!isClosed) emit(SignUpSuccess("مرحباً بك يا $name! ✅"));
      }
    });
  }

  Future<void> signUpUser() async {
    if (!formKey.currentState!.validate()) return;
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
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
          emit(SignUpSuccess("تم إنشاء الحساب بنجاح!"));
        }
      }
    } on AuthException catch (e) {
      emit(SignUpError(_mapSupabaseError(e.message)));
    } catch (e) {
      emit(SignUpError("حدث خطأ غير متوقع. حاول مرة أخرى. 🚧"));
    }
  }

  Future<void> signUpWithGoogle() async {
    emit(SignUpLoading());
    try {
      await _signUpRepository.signInWithGoogle();
    } catch (e) {
      emit(SignUpError("فشل تسجيل الدخول بجوجل 🚨"));
    }
  }



  String _mapSupabaseError(String message) {
    message = message.toLowerCase();
    if (message.contains("user already registered")) return "البريد الإلكتروني مستخدم بالفعل. ⚠️";
    if (message.contains("password should be at least")) return "كلمة المرور ضعيفة جداً. 🔒";
    return "فشل العملية: $message";
  }
}