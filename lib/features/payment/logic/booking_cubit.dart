import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/model/booking.dart';
import '../data/repo.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingStates> {
  final BookingRepository repository;
  String selectedWallet = 'orange';
  BookingModel? currentBookingData;
  BookingCubit(this.repository) : super(BookingInitial());
  void updateBookingData(BookingModel data) {
    currentBookingData = data;
  }
  Future<void> confirmBooking(BookingModel booking) async {
    if (booking.paymentMethod != 'AQUA') {
    emit(BookingError("نعتذر، محفظة AQUA هي المتاحة فقط حالياً."));
    return;
  }
    emit(BookingLoading());

    try {
      await repository.confirmBooking(booking);

      emit(BookingSuccess());
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  void changeWallet(String walletName) {
    selectedWallet = walletName;
    emit(BookingInitial());
  }
}

//بيكلم ال repo عشان ينفذ الحجز في الداتا بيز
