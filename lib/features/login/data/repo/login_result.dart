/// نتيجة عملية تسجيل الدخول — Pure Dart, zero Supabase imports.
///
/// ❌ قبل: LoginRepository كانت بترجع AuthResponse (Supabase type)
/// ✅ بعد: بترجع LoginResult (type خاص بينا)
class LoginResult {
  final String userId;
  final String email;
  final String name;
  final String? avatarUrl;

  const LoginResult({
    required this.userId,
    required this.email,
    required this.name,
    this.avatarUrl,
  });
}
