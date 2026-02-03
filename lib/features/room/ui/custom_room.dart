import 'package:flutter/material.dart';
import 'package:hotel_guide/features/room/ui/widget/room_details_page.dart';

import '../../../core/network/model/room.dart';

class CustomRoom extends StatelessWidget {
  const CustomRoom({super.key, required this.room});
  final Room room;
  @override
  Widget build(BuildContext context) {
    return RoomDetailsPage(room: room,);
  }
}
