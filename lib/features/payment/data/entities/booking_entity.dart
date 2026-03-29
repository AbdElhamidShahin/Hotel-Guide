/// Pure Dart entity — NO Supabase, NO Flutter, NO external packages.
/// This is the heart of the Domain layer.
class BookingEntity {
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

  const BookingEntity({
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

  BookingEntity copyWith({
    String? userId,
    String? paymentMethod,
    double? totalAmount,
  }) {
    return BookingEntity(
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
