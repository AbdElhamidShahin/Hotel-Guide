import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/model/booking.dart';
import '../data/repo.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingStates> {
  final BookingRepository repository;
  BookingCubit(this.repository) : super(BookingInitial());

  Future<void> confirmBooking(BookingModel booking) async {
    print("--- 🏁 بداية عملية الحجز ---");
    print("📦 البيانات المرسلة: ${booking.hotelName}, السعر: ${booking.totalPrice}");

    emit(BookingLoading());

    try {
      await repository.confirmBooking(booking);

      print("✅ نجحت العملية في قاعدة البيانات");
      emit(BookingSuccess());
    } catch (e) {
      print("❌ فشلت العملية: $e");
      emit(BookingError(e.toString()));
    }
  }
}