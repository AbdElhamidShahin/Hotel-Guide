import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/model/booking_model.dart';

/// Handles booking persistence operations only.
abstract class BookingRepository {
  Future<Either<Failure, void>> confirmBooking(BookingModel booking);
}
