/// Core booking data model shared across layers.
class BookingModel {
  final String hotelName;
  final double totalAmount;
  final String roomId;
  final DateTime startDate;
  final DateTime endDate;
  final int roomCount;
  final int adults;
  final int children;
  final int totalDays;
  final String userId;
  final String paymentMethod;

  const BookingModel({
    required this.hotelName,
    required this.totalAmount,
    required this.roomId,
    required this.startDate,
    required this.endDate,
    required this.roomCount,
    required this.adults,
    required this.children,
    required this.totalDays,
    required this.userId,
    required this.paymentMethod,
  });

  Map<String, dynamic> toRpcParams() => {
    'p_hotel_name': hotelName,
    'p_total_amount': totalAmount,
    'p_room_id': roomId,
    'p_start_date': startDate.toIso8601String(),
    'p_end_date': endDate.toIso8601String(),
    'p_room_count': roomCount,
    'p_adults': adults,
    'p_children': children,
    'p_total_days': totalDays,
    'p_user_id': userId,
    'p_payment_method': paymentMethod,
  };

  BookingModel copyWith({String? userId, String? paymentMethod}) => BookingModel(
    hotelName: hotelName,
    totalAmount: totalAmount,
    roomId: roomId,
    startDate: startDate,
    endDate: endDate,
    roomCount: roomCount,
    adults: adults,
    children: children,
    totalDays: totalDays,
    userId: userId ?? this.userId,
    paymentMethod: paymentMethod ?? this.paymentMethod,
  );
}