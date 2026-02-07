class UserProfileModel {
  final String id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;
  final double walletBalance;
  final double balance;

  UserProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
    this.walletBalance = 0.0,
    this.balance = 0.0,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] ?? '',
      fullName: map['full_name'] ?? 'مستخدم جديد',
      email: map['email'] ?? '',
      phoneNumber: map['phone_number'],
      avatarUrl: map['avatar_url'],
      walletBalance: (map['wallet_balance'] ?? 0.0).toDouble(),
      balance: (map['wallet_balance'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'avatar_url': avatarUrl,
      'wallet_balance': walletBalance,
      'balance': balance,
    };
  }

  UserProfileModel copyWith({
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
    double? walletBalance,
    double? balance,
  }) {
    return UserProfileModel(
      id: id,
      email: email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      walletBalance: walletBalance ?? this.walletBalance,
      balance: balance ?? this.balance,
    );
  }
}