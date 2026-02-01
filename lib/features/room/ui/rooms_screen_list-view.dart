import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/features/room/logic/room_cubit.dart';
import 'package:hotel_guide/features/room/logic/room_state.dart';
import 'package:hotel_guide/features/room/ui/widget/custom_rooms_list_view_item.dart';
import '../../../core/helpers/contact/build_error_widget.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../core/router/routers.dart';

class RoomsScreenListView extends StatefulWidget {
  const RoomsScreenListView({super.key, required this.hotelId});
  final String hotelId; // ضيف الـ ID هنا
  @override
  State<RoomsScreenListView> createState() => _RoomsScreenListViewState();
}

class _RoomsScreenListViewState extends State<RoomsScreenListView> {
  @override
  void initState() {
    super.initState();
    context.read<RoomCubit>().getRoomsHotel(widget.hotelId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        name: "الغرف",
        onTap: () {
          context.go(routes.homeScreen);
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            if (state is RoomLoading || state is RoomInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RoomLoaded) {
              return GridView.builder(
                itemCount: state.rooms.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 19,
                  mainAxisSpacing: 26,
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 250.h,
                    child: CustomRoomsListViewItem(room: state.rooms[index]),
                  );
                },
              );
            } else if (state is RoomError) {
              return buildNoConnectionWidget();
            }
            return const Center(child: Text("حالة غير معروفة"));
          },
        ),
      ),
    );
  }
}
