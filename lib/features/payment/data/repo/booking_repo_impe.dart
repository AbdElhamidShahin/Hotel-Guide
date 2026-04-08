import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/model/booking_model.dart';
import 'booking_repo.dart';

class BookingRepoImpl implements BookingRepository {
  final SupabaseClient _supabase;

  const BookingRepoImpl(this._supabase);

  @override
  Future<Either<Failure, void>> confirmBooking(BookingModel booking) async {
    try {
      final user = _supabase.auth.currentUser;

      // 1. التحقق من وجود مستخدم
      if (user == null) {
        return const Left(ServerFailure(errorMessage: 'يرجى تسجيل الدخول أولاً لإتمام الحجز.'));
      }

      // 2. تحديث بيانات الحجز بـ ID المستخدم الحالي
      final bookingWithUser = booking.copyWith(userId: user.id);

      // --- حالة الدفع عن طريق AQUA Wallet ---
      if (bookingWithUser.paymentMethod == 'AQUA') {
        // التحقق من الرصيد أولاً
        final profileData = await _supabase
            .from('profiles')
            .select('wallet_balance')
            .eq('id', user.id)
            .single();

        final balance = (profileData['wallet_balance'] as num).toDouble();

        if (balance < bookingWithUser.totalAmount) {
          return const Left(ServerFailure(errorMessage: 'عذراً، رصيد محفظتك غير كافٍ.'));
        }

        // تنفيذ الحجز عبر الـ RPC (لضمان الخصم والحجز كعملية واحدة Transaction)
        await _supabase.rpc(
          'process_hotel_booking',
          params: bookingWithUser.toRpcParams(),
        );
      }

      // --- حالة الدفع عن طريق البطاقة (Card) ---
      else if (bookingWithUser.paymentMethod == 'card') {
        await _supabase.from('bookings').insert({
          'user_id': bookingWithUser.userId,
          'hotel_name': bookingWithUser.hotelName,
          'room_id': bookingWithUser.roomId,
          'total_amount': bookingWithUser.totalAmount,
          'check_in': bookingWithUser.startDate.toIso8601String(),
          'check_out': bookingWithUser.endDate.toIso8601String(),
          'payment_method': bookingWithUser.paymentMethod,
        });
      }

      // --- حالة وسيلة دفع غير مدعومة ---
      else {
        return const Left(ServerFailure(errorMessage: 'وسيلة الدفع المختارة غير مدعومة حالياً.'));
      }

      return const Right(null);
    } on PostgrestException catch (e) {
      // معالجة أخطاء Supabase/Database بشكل خاص
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }
}