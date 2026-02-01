import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/core/network/supabase_failure.dart';
import 'package:hotel_guide/features/room/data/room_repo.dart';
import 'package:hotel_guide/features/room/logic/room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit(this.repository) : super(RoomInitial());
  final RoomRepo repository;

  Future<void> getRoomsHotel(String hotelId) async {
    emit(RoomLoading());
    try {
      final room = await repository.getRooms(hotelId);
      emit(RoomLoaded(room));
    } catch (error) {
      emit(RoomError(error.toString()));
    }
  }
}
