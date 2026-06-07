import 'package:supabase_flutter/supabase_flutter.dart';

// Single source of truth for all Failure types in the app.
// REMOVED the duplicate abstract Failure in core/network/failure/supabase_failure.dart

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

// 🗄️ Supabase - merged from core/network/failure/supabase_failure.dart
class SupabaseFailure extends Failure {
  const SupabaseFailure(super.message);

  factory SupabaseFailure.fromSupabaseError(dynamic error) {
    if (error is PostgrestException) {
      return SupabaseFailure(error.message);
    } else if (error is AuthException) {
      return SupabaseFailure(error.message);
    } else if (error is StorageException) {
      return SupabaseFailure(error.message);
    } else {
      return const SupabaseFailure('حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.');
    }
  }

  factory SupabaseFailure.fromGenericError(Object? error) {
    final errorStr = error.toString();

    if (errorStr.contains('SocketException') ||
        errorStr.contains('Connection failed') ||
        errorStr.contains('ClientException') ||
        errorStr.contains('TimeoutException') ||
        errorStr.contains('handled by the client')) {
      return const SupabaseFailure('لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.');
    }

    if (error is PostgrestException) {
      return const SupabaseFailure('مشكلة في الوصول للسيرفر، تأكد من اتصالك.');
    }

    return const SupabaseFailure('حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.');
  }
}
