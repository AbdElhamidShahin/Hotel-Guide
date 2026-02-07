abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;

  LoginSuccess(this.message);
}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError(this.errorMessage);
}

class LoginEmailNotVerified extends LoginState {}
