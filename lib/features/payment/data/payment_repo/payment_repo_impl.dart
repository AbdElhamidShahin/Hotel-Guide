import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/network/model/booking_model.dart';
import '../booking_repo/booking_repo.dart';
import '../entities/booking_entity.dart';

/// Concrete Supabase implementation of [IBookingRepository].
///
/// ✅ SupabaseClient is INJECTED — never accessed via Supabase.instance.client.
/// ✅ All Supabase errors are caught here and re-thrown as [BookingException].
///    The Cubit never sees a PostgrestException or AuthException.
class BookingRepositoryImpl implements IBookingRepository {
  final SupabaseClient _supabase;

  const BookingRepositoryImpl(this._supabase);

  @override
  Future<void> confirmBooking(BookingEntity booking) async {
    try {
      final model = BookingModel.fromEntity(booking);
      await _supabase.rpc(
        'process_hotel_booking',
        params: model.toRpcParams(),
      );
    } on PostgrestException catch (e) {
      throw BookingException(_mapPostgrestError(e));
    } catch (e) {
      throw BookingException('حدث خطأ أثناء معالجة الحجز: ${e.toString()}');
    }
  }

  @override
  Future<double> fetchWalletBalance(String userId) async {
    try {
      final data = await _supabase
          .from('profiles')
          .select('wallet_balance')
          .eq('id', userId)
          .single();

      return (data['wallet_balance'] as num).toDouble();
    } on PostgrestException catch (e) {
      throw BookingException(_mapPostgrestError(e));
    } catch (e) {
      throw BookingException('فشل تحميل رصيد المحفظة.');
    }
  }

  // ── Private error mapper ───────────────────────────────────────────────
  String _mapPostgrestError(PostgrestException e) {
    // Map known Supabase/Postgres error codes to human-readable Arabic messages
    switch (e.code) {
      case 'insufficient_balance':
        return 'رصيد المحفظة غير كافٍ.';
      case 'room_not_available':
        return 'الغرفة غير متاحة في التواريخ المحددة.';
      case '23503':
        return 'بيانات غير صالحة، تأكد من تفاصيل الحجز.';
      default:
        return e.message.isNotEmpty
            ? e.message
            : 'حدث خطأ في الخادم، يرجى المحاولة لاحقاً.';
    }
  }
}
