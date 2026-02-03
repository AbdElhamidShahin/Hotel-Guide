class BookingModel {
  final String roomId;
  final String userId;
  final String hotelName;
  final DateTime startDate;
  final DateTime endDate;
  final double totalPrice;
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
    required this.totalPrice,
    required this.paymentMethod,
    required this.roomCount,
    required this.adults,
    required this.children,
    required this.totalDays,
  });

  BookingModel copyWith({String? userId, String? paymentMethod}) {
    return BookingModel(
      roomId: roomId,
      hotelName: hotelName,
      startDate: startDate,
      endDate: endDate,
      totalPrice: totalPrice,
      roomCount: roomCount,
      adults: adults,
      children: children,
      totalDays: totalDays,
      userId: userId ?? this.userId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
