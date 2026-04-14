abstract class Failure {
  final String message;
  const Failure(this.message);
}

// 🔴 Server (API)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// 🌐 Network (No Internet)
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

// 🔐 Auth
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

// 💳 Payment
class PaymentFailure extends Failure {
  const PaymentFailure(super.message);
}

// ⚠️ Unknown
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}