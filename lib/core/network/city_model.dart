// city_model.dart
import 'hotel_model.dart';

class CityModel {
  final int id;
  final String name;
  final String imageUrl;
  final List<HotelModel> hotels; // خليناها أساسية مش Optional لسهولة التعامل

  CityModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.hotels,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      // هنا بنحول لستة الفنادق اللي جات جوه المدينة
      hotels: json['hotel'] != null
          ? (json['hotel'] as List).map((e) => HotelModel.fromJson(e)).toList()
          : [],
    );
  }
}