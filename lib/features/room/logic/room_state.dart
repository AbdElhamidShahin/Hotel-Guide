import 'package:hotel_guide/core/network/model/room.dart';

abstract class RoomState {}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final List<Room> room;

  RoomLoaded(this.room);
}

class RoomError extends RoomState {
  final String error;

  RoomError(this.error);
}
