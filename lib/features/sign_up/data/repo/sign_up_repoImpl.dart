import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_guide/features/sign_up/data/repo/sign_up_repo.dart';

class SignUpRepoimpl implements SignUpRepostry {
  final FirebaseAuth _auth;

  SignUpRepoimpl(this._auth);

  @override
  Future<UserCredential> signUp(
    String email,
    String password,
    String name,
    String confirmPassword,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name);
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
