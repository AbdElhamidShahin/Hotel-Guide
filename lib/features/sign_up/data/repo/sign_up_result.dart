
class SignUpResult {
  final String userId;
  final String email;
  final String name;
  final String? avatarUrl;

  final bool requiresEmailVerification;

  const SignUpResult({
    required this.userId,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.requiresEmailVerification,
  });
}