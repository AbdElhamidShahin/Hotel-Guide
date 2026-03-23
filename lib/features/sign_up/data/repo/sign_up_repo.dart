import 'sign_up_result.dart';

abstract class SignUpRepository {
  Future<SignUpResult> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<SignUpResult> signInWithGoogle();
}
