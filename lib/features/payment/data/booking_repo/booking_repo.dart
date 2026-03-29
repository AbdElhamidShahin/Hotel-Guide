import '../entities/booking_entity.dart';

/// The contract that ALL booking implementations must satisfy.
///
/// The Domain layer depends ONLY on this interface — never on a concrete class.
/// Supabase, Stripe, or any future provider all implement this same contract.
///
/// ✅ DIP (Dependency Inversion Principle): high-level modules (Cubits, UseCases)
///    depend on this abstraction, not on SupabaseClient or BookingRepository directly.
abstract class IBookingRepository {
  /// Confirms a booking using the payment method embedded in [booking].
  /// Throws a typed [BookingException] on failure — never raw Supabase errors.
  Future<void> confirmBooking(BookingEntity booking);

  /// Returns current wallet balance for the authenticated user.
  /// Kept here so the balance check lives inside the repository, not the Cubit.
  Future<double> fetchWalletBalance(String userId);
}

/// Typed domain exception — the Cubit only ever sees this, never PostgrestException.
class BookingException implements Exception {
  final String message;
  const BookingException(this.message);

  @override
  String toString() => 'BookingException: $message';
}
