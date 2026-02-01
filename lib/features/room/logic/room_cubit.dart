import 'package:flutter_bloc/flutter_bloc.dart'; // تأكد من وجود ده
import '../data/room_repo.dart';
import 'room_state.dart';

class RoomCubit extends Cubit<RoomState> { // لازم يكون فيه extends Cubit
  final RoomRepo repository; // تأكد من تعريف الـ repository هنا

  RoomCubit(this.repository) : super(RoomInitial());

  Future<void> getRoomsHotel(String hotelId) async {
    // السطر ده لازم يطبع فوراً أول ما الشاشة تفتح
    print("🔥🔥 [TEST]: getRoomsHotel called with ID: $hotelId");

    if (isClosed) return;
    emit(RoomLoading());

    try {
      print("📡 [TEST]: Calling Repository...");
      final rooms = await repository.getRooms(hotelId);

      print("✅ [TEST]: Success! Found ${rooms.length} rooms.");

      if (!isClosed) emit(RoomLoaded(rooms));
    } catch (error) {
      print("❌ [TEST]: Error caught: $error");
      if (!isClosed) emit(RoomError(error.toString()));
    }
  }
}