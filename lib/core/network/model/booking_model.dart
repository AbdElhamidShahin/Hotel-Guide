import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String roomId;
  final String userId;
  final String hotelName;
  final DateTime checkIn;
  final DateTime checkOut;
  final double totalAmount;
  final String paymentMethod;
  final int roomCount;
  final int adults;
  final int children;

  const BookingEntity({
    required this.roomId,
    required this.userId,
    required this.hotelName,
    required this.checkIn,
    required this.checkOut,
    required this.totalAmount,
    required this.paymentMethod,
    required this.roomCount,
    required this.adults,
    required this.children,
  });

  int get totalNights => checkOut.difference(checkIn).inDays;

  @override
  List<Object?> get props => [
    roomId,
    userId,
    hotelName,
    checkIn,
    checkOut,
    totalAmount,
    paymentMethod,
    roomCount,
    adults,
    children,
  ];

  BookingEntity copyWith({
    String? userId,
    String? paymentMethod,
    double? totalAmount,
  }) {
    return BookingEntity(
      roomId: roomId,
      userId: userId ?? this.userId,
      hotelName: hotelName,
      checkIn: checkIn,
      checkOut: checkOut,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      roomCount: roomCount,
      adults: adults,
      children: children,
    );
  }
}