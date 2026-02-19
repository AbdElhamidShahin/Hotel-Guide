import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/model/hotel_model.dart';
import '../../data/repo/search_repo.dart';
import '../model.dart';
import 'search_state.dart';


class SearchCubit extends Cubit<SearchState> {
  final SearchRepo repo;
  String? _currentQuery;
  FilterOptions? _currentFilter;

  SearchCubit(this.repo) : super(SearchInitial());

  Future<void> loadHotels({String? query, FilterOptions? filter}) async {
    emit(SearchLoading());
    try {
      _currentQuery = query ?? _currentQuery;
      _currentFilter = filter ?? _currentFilter;

      final results = await Future.wait([
        repo.fetchHotels(queryText: _currentQuery, filter: _currentFilter),
        repo.fetchAllCities(),
        repo.fetchAllViews(),
      ]);

      emit(SearchSuccess(
        hotels: results[0] as List<HotelModel>,
        cities: results[1] as List<String>,
        views: results[2] as List<String>,
      ));
    } catch (e) {
      emit(SearchFailure("فشل في تحديث البيانات، حاول مرة أخرى."));
    }
  }

  void search(String query) => loadHotels(query: query);
  void applyFilter(FilterOptions options) => loadHotels(filter: options);
}