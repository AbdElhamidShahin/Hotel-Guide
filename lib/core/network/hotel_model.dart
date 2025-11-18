class HotelModel {
  final int id;
  final String name;
  final String rating;
  final String price;
  final String imageUrl;
  final String imageUrlAll;
  final String isWifi;
  final String view;
  final String breakfast;
  final String location;
  final String locationUrl;
  final String description;
  final int cityId;

  HotelModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.imageUrlAll,
    required this.isWifi,
    required this.breakfast,
    required this.view,
    required this.location,
    required this.locationUrl,
    required this.description,
    required this.cityId,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'] ?? '',
      rating: json['rating'] ?? '',
      price: json['price'] ?? '',
      view: json['view'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      imageUrlAll: json['imageUrlAll'] ?? '',
      isWifi: json['iswifi'] ?? '',
      breakfast: json['breakfast'] ?? '',
      location: json['location'] ?? '',
      locationUrl: json['locationUrl'] ?? '',
      description: json['description'] ?? '',
      cityId: json['city_id'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'price': price,
      'view': view,
      'imageUrl': imageUrl,
      'imageUrlAll': imageUrlAll,
      'iswifi': isWifi,
      'breakfast': breakfast,
      'location': location,
      'locationUrl': locationUrl,
      'description': description,
      'city_id': cityId,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
