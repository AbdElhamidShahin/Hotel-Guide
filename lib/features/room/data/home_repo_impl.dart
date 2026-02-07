import 'package:hotel_guide/core/network/model/room_model.dart';
import 'package:hotel_guide/features/room/data/room_repo.dart';

import '../../../core/network/service/SupabaseService.dart';
import '../../../core/network/failure/supabase_failure.dart';

class RoomRepoImpl implements RoomRepo {
  final SupabaseService _service;

  RoomRepoImpl(this._service);

  @override
  Future<List<Room>> getRooms(String hotelId) async {
    try {
      final data = await _service.fetchRooms(hotelId);
      return data.map((json) => Room.fromJson(json)).toList();
    } catch (error) {
      throw SupabaseFailure.fromGenericError(error);
    }
  }
}
