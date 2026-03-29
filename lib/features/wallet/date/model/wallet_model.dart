
import '../wallet_entity.dart';

/// Maps between Supabase `profiles` table rows and [WalletEntity].
class WalletModel {
  final String id;
  final String fullName;
  final String email;
  final String? avatarUrl;
  final double walletBalance;

  const WalletModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.avatarUrl,
    required this.walletBalance,
  });

  // ── Mapper: Supabase JSON → Model ──────────────────────────────────────
  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'] as String? ?? '',
      fullName: map['full_name'] as String? ?? 'مستخدم جديد',
      email: map['email'] as String? ?? '',
      avatarUrl: map['avatar_url'] as String?,
      walletBalance: (map['wallet_balance'] as num? ?? 0).toDouble(),
    );
  }

  // ── Mapper: Model → Entity ─────────────────────────────────────────────
  WalletEntity toEntity() {
    return WalletEntity(
      userId: id,
      fullName: fullName,
      email: email,
      avatarUrl: avatarUrl,
      balance: walletBalance,
    );
  }
}

/// Maps between Supabase `wallet_transactions` rows and [TransactionEntity].
class TransactionModel {
  final String id;
  final String userId;
  final double amount;
  final String type;
  final String? hotelName;
  final DateTime? bookingStartDate;
  final DateTime createdAt;
  final String status;

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    this.hotelName,
    this.bookingStartDate,
    required this.createdAt,
    required this.status,
  });

  // ── Mapper: Supabase JSON → Model ──────────────────────────────────────
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    final booking = map['bookings'] as Map<String, dynamic>?;

    return TransactionModel(
      id: map['id']?.toString() ?? '',
      userId: map['user_id'] as String? ?? '',
      amount: (map['amount'] as num? ?? 0).toDouble(),
      type: map['type'] as String? ?? 'booking',
      hotelName: booking?['hotel_name'] as String?,
      bookingStartDate: booking?['start_date'] != null
          ? DateTime.tryParse(booking!['start_date'].toString())
          : null,
      createdAt: DateTime.tryParse(map['created_at']?.toString() ?? '') ??
          DateTime.now(),
      status: map['status'] as String? ?? 'completed',
    );
  }

  // ── Mapper: Model → Entity ─────────────────────────────────────────────
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      userId: userId,
      amount: amount,
      type: type,
      hotelName: hotelName,
      bookingStartDate: bookingStartDate,
      createdAt: createdAt,
      status: status,
    );
  }
}
