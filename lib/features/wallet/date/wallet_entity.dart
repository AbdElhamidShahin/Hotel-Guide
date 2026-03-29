/// Pure Dart entity representing the user's wallet state.
class WalletEntity {
  final String userId;
  final String fullName;
  final String email;
  final String? avatarUrl;
  final double balance;

  const WalletEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    this.avatarUrl,
    required this.balance,
  });

  WalletEntity copyWith({double? balance}) {
    return WalletEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      avatarUrl: avatarUrl,
      balance: balance ?? this.balance,
    );
  }
}

/// Pure Dart entity for a single wallet transaction.
class TransactionEntity {
  final String id;
  final String userId;
  final double amount;
  final String type; // 'booking' | 'topup' | 'refund'
  final String? hotelName;
  final DateTime? bookingStartDate;
  final DateTime createdAt;
  final String status; // 'completed' | 'pending' | 'failed'

  const TransactionEntity({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    this.hotelName,
    this.bookingStartDate,
    required this.createdAt,
    required this.status,
  });
}
