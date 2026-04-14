import 'package:flutter/foundation.dart';
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
      data: {'name': name, 'full_name': name},
    );

    final user = response.user;
    if (user == null) throw Exception('فشل إنشاء الحساب، يرجى المحاولة مرة أخرى');

    // ✅ Create profile immediately so wallet never gets PGRST116
    try {
      await _supabase.from('profiles').upsert({
        'id': user.id,
        'full_name': name,
        'email': email,
        'wallet_balance': 0.0,
      });
    } catch (e) {
      debugPrint('⚠️ Profile upsert failed (may already exist): $e');
    }

    return SignUpResult(
      userId: user.id,
      email: user.email ?? email,
      name: name,
      avatarUrl: null,
      requiresEmailVerification: response.session == null,
    );
  }

  @override
  Future<SignUpResult> signInWithGoogle() async {
    // ✅ Use the correct deep-link scheme matching AndroidManifest
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.hotelguide://login-callback',
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