import 'package:hotel_guide/core/network/model/room.dart';

abstract class RoomRepo {
  Future<List<Room>> getRooms(String hotelId);
}
