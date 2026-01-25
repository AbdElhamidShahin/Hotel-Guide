import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/colors.dart';

class CustomRoomsAndLocationDetailsScreen extends StatelessWidget {
  const CustomRoomsAndLocationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 191.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "الموقع",
                  style: textStyle20BoldShadowPurple.copyWith(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 20.w),
                SvgPicture.asset("assets/icons/map.svg"),
              ],
            ),
          ),
        ),

        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () {
            context.go(routes.RoomsScreenListView);
          },

          child: Container(
            width: 191.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "الغرف",
                  style: textStyle20BoldShadowPurple.copyWith(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 20.w),
                SvgPicture.asset("assets/icons/rooms_icon.svg"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
