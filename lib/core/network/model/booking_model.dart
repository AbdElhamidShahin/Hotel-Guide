class BookingModel {
  final String roomId;
  final String userId;
  final String hotelName;
  final DateTime startDate;
  final DateTime endDate;
  final double totalAmount;
  final String paymentMethod;
  final int roomCount;
  final int adults;
  final int children;
  final int totalDays;

  BookingModel({
    required this.roomId,
    required this.userId,
    required this.hotelName,
    required this.startDate,
    required this.endDate,
    required this.totalAmount,
    required this.paymentMethod,
    required this.roomCount,
    required this.adults,
    required this.children,
    required this.totalDays,
  });

  Map<String, dynamic> toRpcParams() {
    return {
      'p_user_id': userId,
      'p_hotel_name': hotelName,
      'p_room_id': roomId,
      'p_total_amount': totalAmount,
      'p_check_in': startDate.toIso8601String(),
      'p_check_out': endDate.toIso8601String(),
      // 'p_check_in': startDate.toUtc().toIso8601String(),   // ✅ toUtc() أولاً
      // 'p_check_out': endDate.toUtc().toIso8601String(),    // ✅ toUtc() أولاً
      'p_payment_method': paymentMethod,
    };
  }

  BookingModel copyWith({
    String? userId,
    String? paymentMethod,
    double? totalAmount,
  }) {
    return BookingModel(
      roomId: roomId,
      hotelName: hotelName,
      startDate: startDate,
      endDate: endDate,
      totalAmount: totalAmount ?? this.totalAmount,
      roomCount: roomCount,
      adults: adults,
      children: children,
      totalDays: totalDays,
      userId: userId ?? this.userId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}