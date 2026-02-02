class BookingModel {
  final String roomId;
  final String userId;
  final String hotelName;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final int roomCount;
  final int adults;
  final int children;
  final double totalPrice;
  final String paymentMethod;

  BookingModel({
    required this.roomId,
    required this.userId,
    required this.hotelName, // ✅ مطلوب هنا
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.roomCount,
    required this.adults,
    required this.children,
    required this.totalPrice,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'room_id': roomId,
      'user_id': userId,
      'hotel_name': hotelName,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'total_days': totalDays,
      'rooms': roomCount,
      'adults': adults,
      'children': children,
      'total_price': totalPrice,
      'payment_method': paymentMethod,
      'status': 'confirmed',
    };
  }
}