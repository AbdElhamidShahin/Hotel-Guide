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

// في ملف supabase_failure.dart (مهم جداً)

  factory SupabaseFailure.fromGenericError(Object? error) {
    if (error == null) {
      return SupabaseFailure("حدث خطأ غير معروف.");
    } else if (error.toString().contains("SocketException")) { // <--- هنا يتم اكتشاف خطأ الاتصال
      return SupabaseFailure("لا يوجد اتصال بالإنترنت.");
    } else {
      return SupabaseFailure("حدث خطأ غير متوقع: ${error.toString()}");
    }
  }
}
