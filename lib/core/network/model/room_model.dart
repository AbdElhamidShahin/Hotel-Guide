class Room {
  final String id;
  final String hotelId;
  final String name;
  final double price;
  final double? discountPrice;
  final Map<String, dynamic> facilities;
  final bool isAvailable;
  final int capacity;
  final int area;
  final List<String> gallery;
  final String bedType;
  final DateTime createdAt;

  Room({
    required this.id,
    required this.hotelId,
    required this.name,
    required this.price,
    this.discountPrice,
    required this.facilities,
    required this.isAvailable,
    required this.capacity,
    required this.area,
    required this.gallery,
    required this.bedType,
    required this.createdAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'].toString(),
      hotelId: json['hotel_id'].toString(),
      name: json['name'] as String? ?? 'غرفة غير مسمى',

      price: (json['price'] as num? ?? 0).toDouble(),
      discountPrice: json['discount_price'] != null
          ? (json['discount_price'] as num).toDouble()
          : null,

      facilities: Map<String, dynamic>.from(json['facilities'] ?? {}),
      isAvailable: json['is_available'] as bool? ?? true,

      capacity: (json['capacity'] as num? ?? 0).toInt(),
      area: (json['area'] as num? ?? 0).toInt(),

      gallery: List<String>.from(json['gallery'] ?? []),
      bedType: json['bed_type'] as String? ?? 'Single Bed',

      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  double get finalPrice => discountPrice ?? price;
  double get pricePerNight => finalPrice;
  String? get hotelName => null; // override if hotel data is fetched alongside
}
