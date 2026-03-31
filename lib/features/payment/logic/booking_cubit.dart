import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/model/booking_model.dart';
import '../data/model/payment_intent_input_model.dart';
import '../data/repo/booking_repo.dart';
import '../data/repo/payment_repository.dart';
import 'booking_state.dart';


class BookingCubit extends Cubit<BookingStates> {
  final PaymentRepository _paymentRepository;
  final BookingRepository _bookingRepository;

  String selectedWallet = 'orange';

  BookingCubit({
    required PaymentRepository paymentRepository,
    required BookingRepository bookingRepository,
  })  : _paymentRepository = paymentRepository,
        _bookingRepository = bookingRepository,
        super(const BookingInitial());

  // ── Card payment (Stripe) ──────────────────────────────────────────────────

  Future<void> makePayment({
    required PaymentIntentInputModel input,
    required BookingModel booking,
  }) async {
    emit(const BookingLoading());
    final paymentResult = await _paymentRepository.makePayment(input: input);

    await paymentResult.fold(
          (failure) async => emit(BookingError(failure.errorMessage)),
          (_) async {
        final bookingResult = await _bookingRepository.confirmBooking(
          booking.copyWith(paymentMethod: 'card'),
        );
        bookingResult.fold(
              (failure) => emit(BookingError(failure.errorMessage)),
              (_) => emit(const BookingSuccess()),
        );
      },
    );
  }

  // ── Wallet payment ────────────────────────────────────────────────────────

  Future<void> confirmBooking(BookingModel booking) async {
    emit(const BookingLoading());
    final result = await _bookingRepository.confirmBooking(booking);
    result.fold(
          (failure) => emit(BookingError(failure.errorMessage)),
          (_) => emit(const BookingSuccess()),
    );
  }

  // ── UI helpers ────────────────────────────────────────────────────────────

  void changeWallet(String walletName) {
    selectedWallet = walletName;
    emit(BookingWalletChanged(walletName));
  }
}