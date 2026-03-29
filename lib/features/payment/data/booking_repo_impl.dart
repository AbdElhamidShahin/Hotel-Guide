import 'package:dart_either/dart_either.dart';
import 'package:hotel_guide/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/model/booking_model.dart';
import 'booking_repo/booking_repo.dart';

class BookingRepositoryImpl implements BookingRepository {
  final SupabaseClient _supabase;

  BookingRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, void>> confirmWithWallet(BookingEntity booking) async {
    try {
      await _supabase.rpc(
        'process_hotel_booking',
        params: {
          'p_user_id': booking.userId,
          'p_hotel_name': booking.hotelName,
          'p_room_id': booking.roomId,
          'p_total_amount': booking.totalAmount,
          'p_check_in': booking.checkIn.toIso8601String(),
          'p_check_out': booking.checkOut.toIso8601String(),
          'p_payment_method': 'AQUA',
        },
      );
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createStripePaymentIntent(double amount) async {
    try {
      final response = await _supabase.functions.invoke(
        'create-payment-intent',
        body: {'amount': amount},
      );
      final clientSecret = response.data['clientSecret'] as String?;
      if (clientSecret == null) {
        return Left(ServerFailure(message: 'لم يتم استقبال بيانات الدفع'));
      }
      return Right(clientSecret);
    } catch (e) {
      return Left(ServerFailure(message: 'فشل إنشاء جلسة الدفع: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> confirmWithStripe(BookingEntity booking) async {
    try {
      await _supabase.rpc(
        'process_hotel_booking',
        params: {
          'p_user_id': booking.userId,
          'p_hotel_name': booking.hotelName,
          'p_room_id': booking.roomId,
          'p_total_amount': booking.totalAmount,
          'p_check_in': booking.checkIn.toIso8601String(),
          'p_check_out': booking.checkOut.toIso8601String(),
          'p_payment_method': 'stripe',
        },
      );
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getWalletBalance(String userId) async {
    try {
      final data = await _supabase
          .from('profiles')
          .select('wallet_balance')
          .eq('id', userId)
          .single();
      final balance = (data['wallet_balance'] as num).toDouble();
      return Right(balance);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}