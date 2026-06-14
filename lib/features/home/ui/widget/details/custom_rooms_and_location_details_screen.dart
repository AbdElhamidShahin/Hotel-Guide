import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/network/model/hotel_model.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

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
              child: _ActionButton(
                label: 'الموقع',
                iconPath: 'assets/icons/map.svg',
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () => context.push(routes.RoomsScreenListView, extra: hotelModel.id),
              child: _ActionButton(
                label: 'الغرف',
                iconPath: 'assets/icons/rooms_icon.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.iconPath});
  final String label;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        // Always primary — branded action buttons, same in both themes.
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Migrated from frozen font20BoldShadowPurple.copyWith(color: textWhite).
          // Always white — text on primary background.
          Text(
            label,
            style: AppTextStyles.font20BoldShadowPurple(context).copyWith(
              color: AppColors.textWhite,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          SvgPicture.asset(iconPath, height: 20.r,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String urlString) async {
  if (!await launchUrl(Uri.parse(urlString))) {
    throw Exception('Could not launch $urlString');
  }
}
