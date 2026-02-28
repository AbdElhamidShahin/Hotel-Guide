import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/model/hotel_model.dart';
import '../../../core/network/service/ai_service.dart';
import '../data/ai_repo.dart';

// States
abstract class ChatSearchState {}
class ChatSearchInitial extends ChatSearchState {}
class ChatSearchLoading extends ChatSearchState {}
class ChatSearchSuccess extends ChatSearchState {
  final List<HotelModel> hotels;
  final String userMessage;
  final String aiResponse; // النص الذكي من Gemini

  ChatSearchSuccess({
    required this.hotels,
    required this.userMessage,
    required this.aiResponse
  });
}
class ChatSearchError extends ChatSearchState {
  final String message;
  ChatSearchError(this.message);
}

// Cubit
class ChatSearchCubit extends Cubit<ChatSearchState> {
  final SearchRepository _repository;
  final AISearchService _service;

  ChatSearchCubit(this._repository, this._service) : super(ChatSearchInitial());

  Future<void> sendQuery(String query) async {
    if (query.trim().isEmpty) return;

    emit(ChatSearchLoading());
    try {
      // 1. جلب الفنادق من الداتابيز
      final hotels = await _repository.searchHotels(query);

      // 2. طلب الرد الذكي بناءً على الفنادق دي
      final smartAnswer = await _service.getSmartResponse(
          userQuery: query,
          foundHotels: hotels
      );

      if (!isClosed) {
        emit(ChatSearchSuccess(
            hotels: hotels,
            userMessage: query,
            aiResponse: smartAnswer
        ));
      }
    } catch (e) {
      if (!isClosed) emit(ChatSearchError("حصلت مشكلة في الاتصال: $e"));
    }
  }
}