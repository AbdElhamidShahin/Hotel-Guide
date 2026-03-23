import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/helpers/local_storage_account.dart';
import '../../data/repo/sign_up_repo.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepository _signUpRepository;

  StreamSubscription<AuthState>? _authSubscription;

  SignUpCubit(this._signUpRepository) : super(SignUpInitial()) {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) async {
      if (data.event != AuthChangeEvent.signedIn) return;

      final user = data.session?.user;
      if (user == null || isClosed) return;

      final String name =
          user.userMetadata?['full_name'] ??
          user.userMetadata?['name'] ??
          user.userMetadata?['display_name'] ??
          'مستخدم جديد';

      final String imageUrl =
          user.userMetadata?['avatar_url'] ??
          user.userMetadata?['picture'] ??
          '';

      final String email = user.email ?? '';

      await UserDataManager.saveUserData(
        name: name,
        email: email,
        image: imageUrl,
        phone: user.userMetadata?['phone'] ?? '',
      );

      if (!isClosed) {
        emit(SignUpSuccess(name: name, email: email));
      }
    });
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      emit(SignUpError('كلمة المرور وتأكيدها غير متطابقين ❌'));
      return;
    }

    emit(SignUpLoading());

    try {
      final result = await _signUpRepository.signUp(
        email: email,
        password: password,
        name: name,
      );

      await UserDataManager.saveUserData(
        name: result.name,
        email: result.email,
        phone: '',
      );

      if (result.requiresEmailVerification) {
        emit(SignUpVerificationRequired(email: result.email));
      } else {
        emit(SignUpSuccess(name: result.name, email: result.email));
      }
    } on AuthException catch (e) {
      emit(SignUpError(_mapError(e.message)));
    } catch (e) {
      emit(SignUpError('حدث خطأ غير متوقع، حاول مرة أخرى 🚧'));
    }
  }

  Future<void> signUpWithGoogle() async {
    emit(SignUpLoading());
    try {
      await _signUpRepository.signInWithGoogle();
    } on AuthException catch (e) {
      emit(SignUpError(_mapError(e.message)));
    } catch (e) {
      emit(SignUpError('فشل تسجيل الدخول بجوجل 🚨'));
    }
  }

  String _mapError(String message) {
    final lower = message.toLowerCase();
    if (lower.contains('user already registered')) {
      return 'البريد الإلكتروني مستخدم بالفعل ⚠️';
    }
    if (lower.contains('password should be at least')) {
      return 'كلمة المرور ضعيفة جداً 🔒';
    }
    if (lower.contains('invalid email')) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return 'فشل العملية: $message';
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}
