
import '../../../features/payment/data/entities/booking_entity.dart';

/// Data-layer model. Knows about Supabase RPC params.
///
/// ✅ Strict separation: BookingEntity (Domain) ←→ BookingModel (Data).
/// The Domain layer never imports this file.
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

  const BookingModel({
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

  // ── Mapper: Entity → Model ─────────────────────────────────────────────
  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      roomId: entity.roomId,
      userId: entity.userId,
      hotelName: entity.hotelName,
      startDate: entity.startDate,
      endDate: entity.endDate,
      totalAmount: entity.totalAmount,
      paymentMethod: entity.paymentMethod,
      roomCount: entity.roomCount,
      adults: entity.adults,
      children: entity.children,
      totalDays: entity.totalDays,
    );
  }

  // ── Mapper: Model → Entity ─────────────────────────────────────────────
  BookingEntity toEntity() {
    return BookingEntity(
      roomId: roomId,
      userId: userId,
      hotelName: hotelName,
      startDate: startDate,
      endDate: endDate,
      totalAmount: totalAmount,
      paymentMethod: paymentMethod,
      roomCount: roomCount,
      adults: adults,
      children: children,
      totalDays: totalDays,
    );
  }

  // ── Supabase RPC serializer ────────────────────────────────────────────
  Map<String, dynamic> toRpcParams() {
    return {
      'p_user_id': userId,
      'p_hotel_name': hotelName,
      'p_room_id': roomId,
      'p_total_amount': totalAmount,
      'p_check_in': startDate.toIso8601String(),
      'p_check_out': endDate.toIso8601String(),
      'p_payment_method': paymentMethod,
    };
  }
}
