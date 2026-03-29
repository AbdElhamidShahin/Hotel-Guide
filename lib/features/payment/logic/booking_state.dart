import 'package:equatable/equatable.dart';
import '../../../core/network/model/booking_model.dart';

abstract class BookingState extends Equatable {
  const BookingState();
  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {
  final String selectedWallet;
  const BookingInitial({this.selectedWallet = 'AQUA'});
  @override
  List<Object?> get props => [selectedWallet];
}

class BookingLoading extends BookingState {}

class StripeLoading extends BookingState {}

class StripeReady extends BookingState {
  final String clientSecret;
  final BookingEntity pendingBooking;
  const StripeReady(this.clientSecret, this.pendingBooking);
  @override
  List<Object?> get props => [clientSecret, pendingBooking];
}

class BookingSuccess extends BookingState {}

class BookingError extends BookingState {
  final String message;
  const BookingError(this.message);
  @override
  List<Object?> get props => [message];
}