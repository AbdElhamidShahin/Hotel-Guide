class Booking {
  final String id;
  final String userId; // Firebase UID
  final String hotelName;
  final DateTime checkIn;
  final DateTime checkOut;
  final double totalAmount;
  final String status;

  Booking({
    required this.id,
    required this.userId,
    required this.hotelName,
    required this.checkIn,
    required this.checkOut,
    required this.totalAmount,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['user_id'],
      hotelName: json['hotels']['name'],
      checkIn: DateTime.parse(json['check_in']),
      checkOut: DateTime.parse(json['check_out']),
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json['booking_status'],
    );
  }
}