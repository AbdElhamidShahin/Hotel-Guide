import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';

import '../../../../core/network/model/room_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

class BookNowButton extends StatelessWidget {
  const BookNowButton({super.key, required this.room,});
  final Room room;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 183.w,
      height: 65.h,
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      child: ElevatedButton(
        onPressed: () {
          context.push(routes.BookingDetailsPage, extra: room);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("إحجز الآن", style: font22BoldPrimary),

            SizedBox(width: 8.w),
            SvgPicture.asset("assets/icons/send.svg"),
          ],
        ),
      ),
    );
  }
}
