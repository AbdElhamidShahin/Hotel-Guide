import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/supabase_failure.dart';
import 'search_state.dart';
import '../../data/repo/search_repo.dart';
import '../../../../core/network/hotel_model.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo repo;
  List<HotelModel> allHotels = [];

  SearchCubit(this.repo) : super(SearchInitial());

  Future<void> loadHotels() async {
    emit(SearchLoading());
    allHotels.clear();
    try {
      allHotels = await repo.fetchHotels();
      emit(SearchSuccess(allHotels));
    } catch (e) {
      final failure = SupabaseFailure.fromGenericError(e);
      emit(SearchFailure(failure.errorMessage));
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      emit(SearchSuccess(allHotels));
      return;
    }

    final results = allHotels.where((hotel) {
      final nameMatch = hotel.name.toLowerCase().contains(query.toLowerCase());
      final descMatch = hotel.description.toLowerCase().contains(
        query.toLowerCase(),
      );

      return nameMatch || descMatch;
    }).toList();

    emit(SearchSuccess(results));
  }
}
