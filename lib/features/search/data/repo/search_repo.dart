import '../../../../core/network/hotel_model.dart';
import '../../../../core/network/model/hotel.dart';

abstract class SearchRepo {
  Future<List<HotelModel>> fetchHotels();
}
