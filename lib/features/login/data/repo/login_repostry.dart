import 'login_result.dart';

/// ❌ قبل: LoginRepostry  ← typo في الاسم
/// ✅ بعد: LoginRepository ← اسم صح
///
/// ❌ قبل: Future<AuthResponse> ← Supabase type في الـ Domain
/// ✅ بعد: Future<LoginResult>  ← type خاص بينا
abstract class LoginRepository {
  Future<LoginResult> login(String email, String password);
}
