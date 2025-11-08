
import 'package:firebase_auth/firebase_auth.dart';
import 'login_repostry.dart';
class AuthRepositoryImpl implements LoginRepostry {
  final FirebaseAuth _auth;

  AuthRepositoryImpl(this._auth);

  @override
  Future<UserCredential> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}