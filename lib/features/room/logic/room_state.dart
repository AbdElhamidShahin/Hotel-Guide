import 'package:hotel_guide/core/network/model/room_model.dart';

abstract class RoomState {}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final List<Room> rooms;

  RoomLoaded(this.rooms);
}

class RoomError extends RoomState {
  final String error;

  RoomError(this.error);
}
