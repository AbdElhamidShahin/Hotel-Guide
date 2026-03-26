/// ❌ قبل: LoginEmailNotVerified موجودة بس مش بتتـ emit — dead code
/// ✅ بعد: حذفناها — بس 4 states حقيقيين
///
/// ❌ قبل: LoginSuccess بيحمل message بس
/// ✅ بعد: LoginSuccess بيحمل name وemail — الـ UI محتاجهم
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String name;
  final String email;

  LoginSuccess({required this.name, required this.email});
}

class LoginError extends LoginState {
  final String errorMessage;
  LoginError(this.errorMessage);
}
