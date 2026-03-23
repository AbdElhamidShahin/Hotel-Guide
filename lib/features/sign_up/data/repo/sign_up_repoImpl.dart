import 'package:supabase_flutter/supabase_flutter.dart';
import '../repo/sign_up_repo.dart';
import '../repo/sign_up_result.dart';

class SignUpRepoImpl implements SignUpRepository {
  final SupabaseClient _supabase;

  SignUpRepoImpl(this._supabase);

  @override
  Future<SignUpResult> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );

    final user = response.user;
    if (user == null) {
      throw Exception('فشل إنشاء الحساب، يرجى المحاولة مرة أخرى');
    }
 return SignUpResult(
      userId: user.id,
      email: user.email ?? email,
      name: user.userMetadata?['name'] as String? ?? name,
      avatarUrl: null,
      requiresEmailVerification: response.session == null,
    );
  }

  @override
  Future<SignUpResult> signInWithGoogle() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'hotelapp://login-callback',
    );

    return const SignUpResult(
      userId: '',
      email: '',
      name: '',
      avatarUrl: null,
      requiresEmailVerification: false,
    );
  }
}
