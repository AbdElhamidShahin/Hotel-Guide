import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepostry {
  Future<UserCredential> login(String email, String password);
}
