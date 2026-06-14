import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/room/ui/widget/book_now_button.dart';
import '../../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../../core/network/model/room_model.dart';
import '../../../../core/theme/app_theme_data.dart';
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
    final List<FacilityModel> facilities = room.facilities.entries
        .where((entry) => entry.value == true)
        .map((entry) => FacilityModel(title: entry.key, isAvailable: true))
        .toList();

    return Scaffold(
      appBar: CustomAppbarWidget(name: 'الغرفة', onTap: () => context.pop()),
      // Inherits scaffoldBackgroundColor from AppThemeData automatically.
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
                              context,
                              'assets/icons/maximize-4.svg',
                              'مساحة الغرفة 25 م²',
                            ),
                            SizedBox(width: 10.w),
                            _buildInfoChip(
                              context,
                              'assets/icons/wind-2.svg',
                              'حمام سباحة',
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          'المرافق',
                          style: AppTextStyles.font22BoldPrimary(context)
                              .copyWith(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.primary,
                              ),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(height: 20.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 10.h,
                          children: facilities
                              .map(
                                (facility) => FacilityItem(facility: facility),
                              )
                              .toList(),
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

  Widget _buildInfoChip(BuildContext context, String icon, String text) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        // outline = themed border — adapts in dark mode.
        border: Border.all(color: cs.outline),
        borderRadius: BorderRadius.circular(5.r),
        // surfaceContainerHighest = neutral tinted chip background.
        color: cs.surfaceContainerHighest,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            // Replaced deprecated `color:` with colorFilter.
            colorFilter: ColorFilter.mode(cs.onSurfaceVariant, BlendMode.srcIn),
          ),
          SizedBox(width: 8.w),
          // Migrated from frozen font16RegularMuted global.
          Text(
            text,
            style: AppTextStyles.font16RegularMuted(
              context,
            ).copyWith(color: cs.onSurfaceVariant, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
