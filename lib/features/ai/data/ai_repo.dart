import '../../../core/network/model/hotel_model.dart';
import '../../../core/network/service/ai_service.dart';

class SearchRepository {
  final AISearchService _service;
  SearchRepository(this._service);

  Future<List<HotelModel>> searchHotels(String query) async {
    // بينادي على الميثود اللي بتعمل Vector Search في الـ Service
    return await _service.searchHotelsInDb(query);
  }
}