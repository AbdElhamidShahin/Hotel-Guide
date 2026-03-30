import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/model/booking_model.dart';
import 'booking_repo.dart';

/// Concrete implementation of [BookingRepository].
///
/// All Supabase interactions — including wallet balance validation — live here,
/// not in the Cubit. The Cubit remains presentation-layer only.
///
/// [SupabaseClient] is injected via the constructor so this class is testable.
class BookingRepoImpl implements BookingRepository {
  final SupabaseClient _supabase;

  const BookingRepoImpl(this._supabase);

  @override
  Future<Either<Failure, void>> confirmBooking(BookingModel booking) async {
    try {
      // Guard: only AQUA wallet is supported at this time.
      if (booking.paymentMethod != 'AQUA') {
        return const Left(
          ServerFailure(errorMessage: 'نعتذر، محفظة AQUA هي المتاحة فقط حالياً.'),
        );
      }

      // Fetch the authenticated user.
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return const Left(ServerFailure(errorMessage: 'المستخدم غير مسجل الدخول.'));
      }

      // Check wallet balance.
      final profileData = await _supabase
          .from('profiles')
          .select('wallet_balance')
          .eq('id', user.id)
          .single();

      final balance = (profileData['wallet_balance'] as num).toDouble();

      if (balance < booking.totalAmount) {
        return const Left(
          ServerFailure(errorMessage: 'عفواً، رصيد محفظتك غير كافي لإتمام الحجز.'),
        );
      }

      // Persist the booking via a Supabase RPC call.
      await _supabase.rpc(
        'process_hotel_booking',
        params: booking.copyWith(userId: user.id).toRpcParams(),
      );

      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}