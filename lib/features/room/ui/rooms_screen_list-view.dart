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

class RoomsScreenListView extends StatelessWidget {
  const RoomsScreenListView({super.key, required this.hotelId});
  final String hotelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Inherits scaffoldBackgroundColor from AppThemeData automatically.
      appBar: CustomAppbarWidget(
        name: 'الغرف',
        onTap: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.push(routes.homeScreen);
          }
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            if (state is RoomLoading || state is RoomInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RoomLoaded) {
              if (state.rooms.isEmpty) {
                return _buildEmptyState(context);
              }
              return GridView.builder(
                itemCount: state.rooms.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 19.w,
                  mainAxisSpacing: 26.h,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) =>
                    CustomRoomsListViewItem(room: state.rooms[index]),
              );
            } else if (state is RoomError) {
              return buildNoConnectionWidget();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bed_outlined,
            size: 100.r,
            // onSurfaceVariant = secondary icon colour, adapts in dark mode.
            color: cs.onSurfaceVariant.withOpacity(0.5),
          ),
          SizedBox(height: 20.h),
          Text(
            'عذراً، لا توجد غرف متاحة',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              // onSurface = primary text, adapts in dark mode.
              color: cs.onSurface,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              'يبدو أن هذا الفندق ليس لديه غرف مسجلة حالياً، حاول مرة أخرى لاحقاً.',
              textAlign: TextAlign.center,
              // surfaceTint = textMuted slot, adapts in dark mode.
              style: TextStyle(fontSize: 14.sp, color: cs.surfaceTint),
            ),
          ),
        ],
      ),
    );
  }
}
