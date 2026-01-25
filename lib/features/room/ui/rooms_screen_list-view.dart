import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/room/ui/widget/custom_rooms_list_view_item.dart';

import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../core/theme/app_theme.dart';

class RoomsScreenListView extends StatelessWidget {
  const RoomsScreenListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(name: "الغرف"),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 19,
            mainAxisSpacing: 26,
          ),

          itemBuilder: (BuildContext context, int index) {
            return CustomRoomsListViewItem();
          },
        ),
      ),
    );
  }
}
