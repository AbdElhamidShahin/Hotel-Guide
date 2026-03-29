import 'booking_repo/booking_repo.dart';
import 'entities/booking_entity.dart';

/// Encapsulates the full business logic for confirming a booking.
///
/// Previously, this logic was split across BookingCubit (balance check)
/// and BookingRepository (RPC call) — with a direct Supabase call inside the Cubit.
///
/// Now it is a single, testable unit that only knows about domain types.
class ConfirmBookingUseCase {
  final IBookingRepository _repository;

  const ConfirmBookingUseCase(this._repository);

  /// Validates payment method, checks wallet balance, then delegates to the repo.
  ///
  /// Throws [BookingException] with an Arabic-language message on any failure.
  Future<void> call(BookingEntity booking) async {
    // ── Rule 1: Only AQUA wallet is currently supported ───────────────────
    if (booking.paymentMethod != 'AQUA') {
      throw const BookingException(
        'نعتذر، محفظة AQUA هي المتاحة فقط حالياً.',
      );
    }

    // ── Rule 2: User must be authenticated ────────────────────────────────
    if (booking.userId.isEmpty) {
      throw const BookingException('المستخدم غير مسجل الدخول.');
    }

    // ── Rule 3: Balance check lives HERE, not in the Cubit ────────────────
    final balance = await _repository.fetchWalletBalance(booking.userId);
    if (balance < booking.totalAmount) {
      throw const BookingException(
        'عفواً، رصيد محفظتك غير كافٍ لإتمام هذا الحجز.',
      );
    }

    // ── All rules passed — confirm the booking ────────────────────────────
    await _repository.confirmBooking(booking);
  }
}
