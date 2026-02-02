abstract class BookingStates {}
class BookingInitial extends BookingStates {}
class BookingLoading extends BookingStates {}
class BookingSuccess extends BookingStates {}
class BookingError extends BookingStates {
  final String message;
  BookingError(this.message);
}