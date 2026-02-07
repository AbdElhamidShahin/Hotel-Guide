import 'package:supabase_flutter/supabase_flutter.dart';
import '../repo/sign_up_repo.dart';
class SignUpRepoImpl implements SignUpRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
        data: {'name': name}    );
  }
}