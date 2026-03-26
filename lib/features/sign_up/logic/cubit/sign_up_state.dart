abstract class SignUpState {}
class SignUpInitial extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {
  final String name;
  final String email;

  SignUpSuccess({required this.name, required this.email});
}
class SignUpVerificationRequired extends SignUpState {
  final String email;
  SignUpVerificationRequired({required this.email});
}
class SignUpError extends SignUpState {
  final String errorMessage;
  SignUpError(this.errorMessage);
}
