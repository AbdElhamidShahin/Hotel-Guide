import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/room/ui/widget/book_now_button.dart';

import '../../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../../core/network/model/room_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../../home/ui/widget/details/custom_name_details.dart';
import 'facility_item.dart';
import 'image_gallery_section.dart';

class FacilityModel {
  final String title;
  final bool isAvailable;

  FacilityModel({required this.title, this.isAvailable = true});
}

class RoomDetailsPage extends StatelessWidget {
  const RoomDetailsPage({super.key, required this.room});
  final Room room;
  @override
  Widget build(BuildContext context) {
    final List<FacilityModel> facilities = room.facilities.entries.map((entry) {
      return FacilityModel(title: entry.key, isAvailable: entry.value);
    }).toList();
    return Scaffold(
      appBar: CustomAppbarWidget(
        name: "الغرفة",
        onTap: () {
          context.go(routes.RoomsScreenListView);
        },
      ),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.h),

                        CustomNameDetails(name: room.name),
                        SizedBox(height: 12.h),
                        ImageGallerySection(images: room.gallery),
                        Row(
                          children: [
                            _buildInfoChip(
                              "assets/icons/maximize-4.svg",
                              "مساحة الغرفة 25 م²",
                            ),
                            SizedBox(width: 10.w),
                            _buildInfoChip(
                              "assets/icons/wind-2.svg",
                              "حمام سباحة",
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          "المرافق",
                          style: textStyle22BoldPrimary.copyWith(
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(height: 20.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 10.h,
                          children: facilities.map((facility) {
                            return FacilityItem(facility: facility);
                          }).toList(),
                        ),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
                BookNowButton(room: room),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.ShadowPurple.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(5.r),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, color: AppColors.ShadowPurple),
          SizedBox(width: 8.w),
          Text(
            text,
            style: textStyle16RegularGray.copyWith(
              color: AppColors.ShadowPurple,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
