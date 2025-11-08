import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpRepostry {
  Future<UserCredential> signUp(
    String email,
    String password,
    String name,
    String confirmPassword,
  );
}
