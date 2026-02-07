
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String message;
  SignUpSuccess(this.message);
}

class SignUpError extends SignUpState {
  final String errorMessage;
  SignUpError(this.errorMessage);
}

class SignUpEmailNotVerified extends SignUpState {}
class SignUpVerificationRequired extends SignUpState {
  final String email;
  SignUpVerificationRequired(this.email);
}