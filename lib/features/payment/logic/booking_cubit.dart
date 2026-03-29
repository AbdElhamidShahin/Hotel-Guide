import 'package:dart_either/dart_either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/model/booking_model.dart';
import '../data/booking_repo/booking_repo.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository _repository;

  BookingCubit(this._repository) : super(const BookingInitial());

  void changeWallet(String wallet) {
    emit(BookingInitial(selectedWallet: wallet));
  }

  Future<void> confirmWithWallet(BookingEntity booking) async {
    emit(BookingLoading());
    final user = _getCurrentUser();
    if (user == null) {
      emit(const BookingError('المستخدم غير مسجل'));
      return;
    }

    final balanceResult = await _repository.getWalletBalance(user.id);
    if (balanceResult.isLeft) {
      emit(BookingError(_mapFailureToMessage(balanceResult.as Left().value)));
      return;
    }

    final balance = balanceResult.asRight().value;
    if (balance < booking.totalAmount) {
      emit(const BookingError('عفواً، رصيد محفظتك غير كافٍ'));
      return;
    }

    final finalBooking = booking.copyWith(
      userId: user.id,
      paymentMethod: 'AQUA',
    );

    final result = await _repository.confirmWithWallet(finalBooking);
    result.fold(
          (failure) => emit(BookingError(_mapFailureToMessage(failure))),
          (_) => emit(BookingSuccess()),
    );
  }

  Future<void> initiateStripePayment(BookingEntity booking) async {
    emit(StripeLoading());
    final user = _getCurrentUser();
    if (user == null) {
      emit(const BookingError('المستخدم غير مسجل'));
      return;
    }

    final finalBooking = booking.copyWith(
      userId: user.id,
      paymentMethod: 'stripe',
    );

    final result = await _repository.createStripePaymentIntent(finalBooking.totalAmount);
    result.fold(
          (failure) => emit(BookingError(_mapFailureToMessage(failure))),
          (clientSecret) => emit(StripeReady(clientSecret, finalBooking)),
    );
  }

  Future<void> confirmStripeBooking(BookingEntity booking) async {
    emit(BookingLoading());
    final result = await _repository.confirmWithStripe(booking);
    result.fold(
          (failure) => emit(BookingError(_mapFailureToMessage(failure))),
          (_) => emit(BookingSuccess()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return failure.message;
    return 'حدث خطأ غير متوقع';
  }

  dynamic _getCurrentUser() {
    // Use injected Auth service ideally, but for now:
    // return Supabase.instance.client.auth.currentUser;
    // To avoid direct dependency, we can inject an AuthRepository later.
    return Supabase.instance.client.auth.currentUser;
  }
}