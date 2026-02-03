import 'package:flutter_bloc/flutter_bloc.dart'; // تأكد من وجود ده
import '../data/room_repo.dart';
import 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomRepo repository;

  RoomCubit(this.repository) : super(RoomInitial());

  Future<void> getRoomsHotel(String hotelId) async {
    if (isClosed) return;
    emit(RoomLoading());

    try {
      final rooms = await repository.getRooms(hotelId);

      if (!isClosed) emit(RoomLoaded(rooms));
    } catch (error) {
      if (!isClosed) emit(RoomError(error.toString()));
    }
  }
}
