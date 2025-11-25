import '../../../../core/network/hotel_model.dart';

abstract class SearchRepo {
  Future<List<HotelModel>> fetchHotels();
}
