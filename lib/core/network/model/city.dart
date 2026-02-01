class CityModel {
  final String id;
  final String name;
  final String imageUrl;
  final int hotelsCount;

  CityModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.hotelsCount,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      hotelsCount: json['hotels_count'] ?? 0,
    );
  }
}
