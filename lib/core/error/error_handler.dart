import 'package:dio/dio.dart';
import 'failure.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }

    return const UnknownFailure("Unexpected error occurred");
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const NetworkFailure("Connection timeout");

      case DioExceptionType.sendTimeout:
        return const NetworkFailure("Send timeout");

      case DioExceptionType.receiveTimeout:
        return const NetworkFailure("Receive timeout");

      case DioExceptionType.badResponse:
        return ServerFailure(
          error.response?.data["message"] ?? "Server error",
        );

      case DioExceptionType.cancel:
        return const NetworkFailure("Request cancelled");

      case DioExceptionType.unknown:
        return const NetworkFailure("No Internet connection");

      default:
        return const UnknownFailure("Something went wrong");
    }
  }
}