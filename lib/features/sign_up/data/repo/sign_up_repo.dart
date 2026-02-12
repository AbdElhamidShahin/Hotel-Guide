import 'package:supabase_flutter/supabase_flutter.dart';


abstract class SignUpRepository {
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<void> signInWithGoogle();
}