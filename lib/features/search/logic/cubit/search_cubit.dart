import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/search/data/repo/search_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo repo;

  // all hotels as raw maps or convert to model
  List<Map<String, dynamic>> allHotels = [];
  List<Map<String, dynamic>> filteredHotels = [];

  // dynamic filters map => key -> list of values
  Map<String, List<dynamic>> availableFilters = {};

  // selected filters storage
  Map<String, dynamic> selectedFilters = {
    "city": null,
    "view": null,
    "rating": null,
    "services": <String>[],
    "maxPrice": null,
  };

  SearchCubit(this.repo) : super(SearchInitial());

  bool _isTrue(dynamic v) {
    if (v == null) return false;
    if (v is bool) return v;
    final s = v.toString().toLowerCase();
    return s == 'true' || s == '1' || s == 'yes' || s == 'y';
  }

  Future<void> fetchHotels() async {
    emit(SearchLoading());
    try {
      // fetch raw hotels (implement in repo)
      final hotelsRaw = await repo.fetchCitiesWithHotels();
      filteredHotels = List.from(allHotels);

      // build dynamic filters from data
      _buildAvailableFilters();

      emit(SearchSuccess(filteredHotels));
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }

  void _buildAvailableFilters() {
    final cities = <String>{};
    final views = <String>{};
    final services = <String>{};
    final ratings = <double>{};

    for (var h in allHotels) {
      final city = (h['cityName'] ?? h['city'] ?? h['city_name'] ?? '').toString().trim();
      if (city.isNotEmpty) cities.add(city);

      final view = (h['view'] ?? '').toString().trim();
      if (view.isNotEmpty) views.add(view);

      // services: could be list or comma-separated string
      final rawServ = h['services'];
      if (rawServ != null) {
        if (rawServ is List) {
          for (var s in rawServ) {
            final ss = s.toString().trim();
            if (ss.isNotEmpty) services.add(ss);
          }
        } else {
          final sStr = rawServ.toString();
          // split by comma if needed
          sStr.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).forEach(services.add);
        }
      }

      // rating
      final r = double.tryParse((h['rating'] ?? '').toString()) ?? -1;
      if (r > 0) ratings.add(r);
    }

    availableFilters = {
      'city': cities.toList()..sort(),
      'view': views.toList()..sort(),
      'services': services.toList()..sort(),
      'rating': ratings.toList()..sort(),
    };
  }

  void updateFilter(String key, dynamic value) {
    selectedFilters[key] = value;
    emit(SearchFiltersUpdated());
  }

  void applyFilters() {
    // apply filters on allHotels -> filteredHotels
    final city = selectedFilters['city']?.toString();
    final view = selectedFilters['view']?.toString();
    final rating = selectedFilters['rating'] is double ? selectedFilters['rating'] as double : (selectedFilters['rating'] is int ? (selectedFilters['rating'] as int).toDouble() : null);
    final services = (selectedFilters['services'] as List?)!.cast<String>() ?? <String>[];
    final maxPrice = selectedFilters['maxPrice'] != null ? double.tryParse(selectedFilters['maxPrice'].toString()) : null;

    filteredHotels = allHotels.where((h) {
      // city match: compare cityName fields and fallback to ids
      if (city != null && city.isNotEmpty) {
        final hotelCity = (h['cityName'] ?? h['city'] ?? '').toString();
        if (hotelCity.toLowerCase() != city.toLowerCase()) return false;
      }

      // view: contains match (so "إطلالة على البحر" يطابق "بحر")
      if (view != null && view.isNotEmpty) {
        final hv = (h['view'] ?? '').toString().toLowerCase();
        if (!hv.contains(view.toLowerCase())) return false;
      }

      // rating >=
      if (rating != null) {
        final hr = double.tryParse((h['rating'] ?? '').toString()) ?? 0.0;
        if (hr < rating) return false;
      }

      // max price <=
      if (maxPrice != null) {
        final hp = double.tryParse((h['price'] ?? '').toString()) ?? double.infinity;
        if (hp > maxPrice) return false;
      }

      // services: all selected must exist in hotel's services
      if (services.isNotEmpty) {
        final rawServ = h['services'];
        final hotelServices = <String>{};
        if (rawServ is List) {
          rawServ.map((e) => e.toString().toLowerCase()).forEach(hotelServices.add);
        } else {
          rawServ?.toString().split(',').map((e) => e.trim().toLowerCase()).forEach(hotelServices.add);
        }
        for (var s in services) {
          if (!hotelServices.contains(s.toLowerCase())) return false;
        }
      }

      return true;
    }).toList();

    emit(SearchSuccess(filteredHotels));
    emit(SearchApplied(Map.from(selectedFilters)));
  }

  void clearFilters() {
    selectedFilters.updateAll((key, value) => value is List ? <String>[] : null);
    filteredHotels = List.from(allHotels);
    emit(SearchSuccess(filteredHotels));
    emit(SearchFiltersCleared());
  }

  void searchLocal(String query) {
    if (query.trim().isEmpty) {
      filteredHotels = List.from(allHotels);
      emit(SearchSuccess(filteredHotels));
      return;
    }
    final q = query.toLowerCase();
    filteredHotels = allHotels.where((h) {
      final name = (h['name'] ?? '').toString().toLowerCase();
      final location = (h['location'] ?? '').toString().toLowerCase();
      final city = (h['cityName'] ?? h['city'] ?? '').toString().toLowerCase();
      return name.contains(q) || location.contains(q) || city.contains(q);
    }).toList();

    emit(SearchSuccess(filteredHotels));
  }

  int get filteredCount => filteredHotels.length;
}
