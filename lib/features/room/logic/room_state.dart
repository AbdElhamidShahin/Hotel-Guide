import 'package:hotel_guide/core/network/model/room_model.dart';

abstract class RoomState {}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

// في ملف room_state.dart
class RoomLoaded extends RoomState {
  final List<Room> rooms; // خليها جمع عشان الكود يبقى واضح

  RoomLoaded(this.rooms);
}

class RoomError extends RoomState {
  final String error;

  RoomError(this.error);
}
