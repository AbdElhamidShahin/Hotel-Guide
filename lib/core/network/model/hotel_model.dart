class HotelModel {
  final String id;
  final String cityName;
  final String location;
  final String name;
  final String description;
  final String address;
  final double rating;
  final int reviewsCount;
  final List<String> images;
  final Map<String, dynamic> amenities;
  final double priceStartsFrom;

  HotelModel({
    required this.id,
    required this.cityName,
    required this.name,
    required this.description,
    required this.location,
    required this.address,
    required this.rating,
    required this.reviewsCount,
    required this.images,
    required this.amenities,
    required this.priceStartsFrom,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id']?.toString() ?? '',
      cityName: json['cities'] != null
          ? (json['cities']['name'] ?? 'مدينة غير معروفة')
          : (json['cityName'] ?? 'بدون مدينة'),
      name: json['name'] ?? 'اسم غير متوفر',
      location: json['location'] ?? 'اسم غير متوفر',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      rating: (json['rating'] as num? ?? 0.0).toDouble(),
      reviewsCount: (json['reviews_count'] as int? ?? 0),
      images: json['main_images'] != null
          ? List<String>.from(json['main_images'])
          : (json['images'] != null ? List<String>.from(json['images']) : []),
      amenities: json['amenities'] as Map<String, dynamic>? ?? {},
      priceStartsFrom: (json['price_starts_from'] as num? ?? (json['priceStartsFrom'] as num? ?? 0.0)).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cityName': cityName,
      'name': name,
      'description': description,
      'address': address,
      'rating': rating,
      'location': location,
      'reviews_count': reviewsCount,
      'main_images': images,
      'amenities': amenities,
      'price_starts_from': priceStartsFrom,
    };
  }
}