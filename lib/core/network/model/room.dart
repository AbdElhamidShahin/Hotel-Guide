class Room {
  final String id;
  final String name;
  final double price;
  final double? discountPrice;
  final int capacity;
  final String? vrUrl;
  final Map<String, dynamic> facilities;

  Room({
    required this.id,
    required this.name,    required this.price,

    this.discountPrice,
    required this.capacity,
    this.vrUrl,
    required this.facilities,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      discountPrice: json['discount_price'] != null
          ? (json['discount_price'] as num).toDouble()
          : null,
      capacity: json['capacity'],
      vrUrl: json['vr_url'],
      facilities: json['facilities'],
    );
  }
}