import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/helpers/local_storage_account.dart';
import '../../data/repo/login_repostry.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginCubit(this._loginRepository) : super(LoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    // ✅ FIX #2: Previous code called _loginRepository.login() TWICE
    //    (once before emit(Loading) and again inside the try block).
    //    That caused a duplicate API request on every login.
    emit(LoginLoading());

    try {
      final result = await _loginRepository.login(email, password);

      await UserDataManager.saveUserData(
        name: result.name,
        email: result.email,
        phone: '',
        image: result.avatarUrl,
      );

      emit(LoginSuccess(name: result.name, email: result.email));
    } on AuthException catch (e) {
      emit(LoginError(_mapError(e.message)));
    } catch (e) {
      emit(LoginError('حدث خطأ غير متوقع، يرجى المحاولة لاحقاً 🚧'));
    }
  }

  String _mapError(String message) {
    if (message.contains('Invalid login credentials')) {
      return 'البريد الإلكتروني أو كلمة المرور غير صحيحة 🔑';
    }
    if (message.contains('Email not confirmed')) {
      return 'يرجى تأكيد بريدك الإلكتروني أولاً 📧';
    }
    return 'فشل تسجيل الدخول: $message';
  }
}
