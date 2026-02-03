import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_repostry.dart';

class AuthRepositoryImpl implements LoginRepostry {
  final SupabaseClient _supabaseClient;

  AuthRepositoryImpl(this._supabaseClient);

  @override
  Future<AuthResponse> login(String email, String password) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
}