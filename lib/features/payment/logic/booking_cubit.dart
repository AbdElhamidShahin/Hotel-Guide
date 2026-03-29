import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/repo/i_booking_repository.dart';
import '../../domain/usecases/confirm_booking_usecase.dart';
import '../data/booking_repo/booking_repo.dart';
import '../data/confirm_booking_usecase.dart';
import '../data/entities/booking_entity.dart';
import 'booking_state.dart';

/// ✅ Clean Cubit: zero Supabase imports, zero business logic.
///
/// Before: called Supabase.instance.client directly, ran balance checks,
///         and called the repository — all mixed inside one method.
///
/// After:  delegates ALL logic to [ConfirmBookingUseCase] and only
///         manages UI state in response to the result.
class BookingCubit extends Cubit<BookingState> {
  final ConfirmBookingUseCase _confirmBookingUseCase;

  /// The currently selected wallet provider name, used by the UI only.
  String selectedWallet = 'orange';

  BookingCubit(IBookingRepository repository)
      : _confirmBookingUseCase = ConfirmBookingUseCase(repository),
        super(const BookingInitial());

  // ── Commands ───────────────────────────────────────────────────────────

  Future<void> confirmBooking(BookingEntity booking) async {
    emit(const BookingLoading());
    try {
      await _confirmBookingUseCase(booking);
      emit(const BookingSuccess());
    } on BookingException catch (e) {
      emit(BookingError(e.message));
    } catch (e) {
      emit(BookingError('حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  void changeWallet(String walletName) {
    selectedWallet = walletName;
    emit(const BookingInitial());
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
