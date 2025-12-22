import 'dart:io';

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

    // تشخيص أخطاء الاتصال بشكل أوسع
    if (errorStr.contains("SocketException") ||
        errorStr.contains("Connection failed") ||
        errorStr.contains("ClientException") ||
        errorStr.contains("TimeoutException") || // مهم جداً عشان الـ timeout اللي ضفناه
        errorStr.contains("handled by the client")) {
      return SupabaseFailure("لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.");
    }

    // لو الخطأ من نوع PostgrestException بس سببه برضه اتصال
    if (error is PostgrestException) {
      return SupabaseFailure("مشكلة في الوصول للسيرفر، تأكد من اتصالك.");
    }

    return SupabaseFailure("حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.");
  }
}