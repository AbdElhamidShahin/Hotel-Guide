import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/model/booking_model.dart';
import '../../../core/network/model/profile_model.dart';
import '../data/model/payment_intent_input_model.dart';
import '../data/repo/booking_repo.dart';
import '../data/repo/payment_repository.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingStates> {
  final PaymentRepository _paymentRepository;
  final BookingRepository _bookingRepository;

  String selectedWallet = 'AQUA';


  UserProfileModel? userProfile;

  BookingCubit({
    required PaymentRepository paymentRepository,
    required BookingRepository bookingRepository,
  })  : _paymentRepository = paymentRepository,
        _bookingRepository = bookingRepository,
        super(const BookingInitial());

  // ── Load Profile ───────────────────────────────────────────────────────────

  Future<void> loadUserProfile() async {
    final result = await _bookingRepository.getUserProfile();
    result.fold(
          (failure) => emit(BookingError(failure.message)),
          (profile) {
        userProfile = profile;
        emit(const BookingInitial());
      },
    );
  }

  // ── Payment (Card) ─────────────────────────────────────────────────────────

  Future<void> makePayment({
    required PaymentIntentInputModel input,
    required BookingModel booking,
  }) async {
    emit(const BookingLoading());
    final paymentResult = await _paymentRepository.makePayment(input: input);

    await paymentResult.fold(
          (failure) async => emit(BookingError(failure.message)),
          (_) async {
        final bookingResult = await _bookingRepository.confirmBooking(
          booking.copyWith(paymentMethod: 'card'),
        );
        bookingResult.fold(
              (failure) => emit(BookingError(failure.message)),
              (_) async {
            emit(const BookingSuccess());
            await Future.delayed(const Duration(milliseconds: 300));
          },
        );
      },
    );
  }

  // ── Payment (Wallet) ───────────────────────────────────────────────────────

  Future<void> confirmBooking(BookingModel booking) async {
    emit(const BookingLoading());
    final result = await _bookingRepository.confirmBooking(
      booking.copyWith(paymentMethod: 'AQUA'),
    );
    result.fold(
          (failure) => emit(BookingError(failure.message)),
          (_) => emit(const BookingSuccess()),
    );
  }

  // ── Wallet Selection ───────────────────────────────────────────────────────

  void changeWallet(String walletName) {
    selectedWallet = walletName;
    emit(BookingWalletChanged(walletName));
  }
}
