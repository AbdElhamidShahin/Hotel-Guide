import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/model/booking_model.dart';
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
  double calculateTotalPrice({
    required double pricePerNight,
    required int totalDays,
    required int rooms,
    double taxes = 500,
    double services = 300,
  }) {
    return (pricePerNight * totalDays * rooms) + taxes + services;
  }
  Future<void> confirmBooking(BookingModel booking) async {
    if (booking.paymentMethod != 'AQUA') {
      emit(BookingError("نعتذر، محفظة AQUA هي المتاحة فقط حالياً."));
      return;
    }

    emit(BookingLoading());

    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        emit(BookingError("المستخدم غير مسجل"));
        return;
      }

      final walletData = await Supabase.instance.client
          .from('profiles')
          .select('wallet_balance')
          .eq('id', user.id)
          .single();

      double balance = (walletData['wallet_balance'] as num).toDouble();

      if (balance < booking.totalAmount) {
        emit(BookingError("عفواً، رصيد محفظتك غير كافي لإتمام الحجز."));
        return;
      }

      await repository.confirmBooking(booking);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingError("حدث خطأ أثناء معالجة الحجز: ${e.toString()}"));
    }
  }

  void changeWallet(String walletName) {
    selectedWallet = walletName;
    emit(BookingInitial());
  }
}
