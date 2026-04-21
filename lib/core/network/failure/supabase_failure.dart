import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class SupabaseFailure extends Failure {
  SupabaseFailure(super.errorMessage);

  factory SupabaseFailure.fromSupabaseError(dynamic error) {
    if (error is PostgrestException) {
      return SupabaseFailure(error.message);
    } else if (error is AuthException) {
      return SupabaseFailure(error.message);
    } else if (error is StorageException) {
      return SupabaseFailure(error.message);
    } else {
      return SupabaseFailure("حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.");
    }
  }

  factory SupabaseFailure.fromGenericError(Object? error) {
    String errorStr = error.toString();

    if (errorStr.contains("SocketException") ||
        errorStr.contains("Connection failed") ||
        errorStr.contains("ClientException") ||
        errorStr.contains("TimeoutException") ||
        errorStr.contains("handled by the client")) {
      return SupabaseFailure("لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.");
    }

    if (error is PostgrestException) {
      return SupabaseFailure("مشكلة في الوصول للسيرفر، تأكد من اتصالك.");
    }

    return SupabaseFailure("حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.");
  }
}
