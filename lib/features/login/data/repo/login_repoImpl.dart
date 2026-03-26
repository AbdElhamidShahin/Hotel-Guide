import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_repostry.dart';
import 'login_result.dart';

class LoginRepositoryImpl implements LoginRepository {
  final SupabaseClient _supabaseClient;

  LoginRepositoryImpl(this._supabaseClient);

  @override
  Future<LoginResult> login(String email, String password) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) {
      throw Exception('فشل تسجيل الدخول، يرجى المحاولة مرة أخرى');
    }

    return LoginResult(
      userId: user.id,
      email: user.email ?? email,
      name: user.userMetadata?['name'] as String? ??
          user.userMetadata?['full_name'] as String? ??
          'مستخدم',
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
    );
  }
}
