class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.errorMessage});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.errorMessage});
}