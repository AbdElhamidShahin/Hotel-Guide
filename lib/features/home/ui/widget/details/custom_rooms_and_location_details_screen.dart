import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/network/model/hotel_model.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/colors.dart';

class CustomRoomsAndLocationDetailsScreen extends StatelessWidget {
  const CustomRoomsAndLocationDetailsScreen({super.key, required this.hotelModel});
  final HotelModel hotelModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _launchUrl(hotelModel.location),
              child: Container(
                height: 55.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("الموقع", style: textStyle20BoldShadowPurple.copyWith(color: AppColors.white, fontSize: 16.sp)),
                    SizedBox(width: 12.w),
                    SvgPicture.asset("assets/icons/map.svg", height: 20.r),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () => context.go(routes.RoomsScreenListView, extra: hotelModel.id),
              child: Container(
                height: 55.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("الغرف", style: textStyle20BoldShadowPurple.copyWith(color: AppColors.white, fontSize: 16.sp)),
                    SizedBox(width: 12.w),
                    SvgPicture.asset("assets/icons/rooms_icon.svg", height: 20.r),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String urlString) async {
  if (!await launchUrl(Uri.parse(urlString))) {
    throw Exception("Could not launch $urlString");
  }
}
