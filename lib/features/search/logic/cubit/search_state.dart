abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<dynamic> hotels; // use HotelModel if preferred
  SearchSuccess(this.hotels);
}

class SearchFailure extends SearchState {
  final String errorMessage;
  SearchFailure(this.errorMessage);
}

// dynamic filters states (optional/useful)
class SearchLoaded extends SearchState {} // when filters loaded
class SearchFiltersUpdated extends SearchState {}
class SearchApplied extends SearchState {
  final Map<String, dynamic> filters;
  SearchApplied(this.filters);
}
class SearchFiltersCleared extends SearchState {}
