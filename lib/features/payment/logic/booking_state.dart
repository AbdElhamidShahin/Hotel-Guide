/// Sealed state hierarchy for [BookingCubit].
///
/// ✅ All states are const-constructable — no unnecessary object allocations.
/// ✅ Named consistently with the project's other features (Initial/Loading/Success/Error).
abstract class BookingState {
  const BookingState();
}

class BookingInitial extends BookingState {
  const BookingInitial();
}

class BookingLoading extends BookingState {
  const BookingLoading();
}

class BookingSuccess extends BookingState {
  const BookingSuccess();
}

class BookingError extends BookingState {
  final String message;
  const BookingError(this.message);
}
