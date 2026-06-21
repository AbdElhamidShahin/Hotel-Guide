import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/model/booking_model.dart';
import '../../../../core/network/model/profile_model.dart';

abstract class BookingRepository {
  Future<Either<Failure, void>> confirmBooking(BookingModel booking);

  Future<Either<Failure, UserProfileModel>> getUserProfile();
}
