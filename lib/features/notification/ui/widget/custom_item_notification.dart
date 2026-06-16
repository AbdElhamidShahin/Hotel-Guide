import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../../core/network/model/notification_model.dart';

class CustomItemNotification extends StatelessWidget {
  final NotificationModel notification;
  const CustomItemNotification({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final cs      = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final String assetPath = switch (notification.type) {
      NotificationType.success  => 'assets/images/notification_statuses/success.svg',
      NotificationType.failure  => 'assets/images/notification_statuses/Falier.svg',
      NotificationType.reminder => 'assets/images/notification_statuses/times.svg',
      NotificationType.message  => 'assets/images/notification_statuses/Email.svg',
    };

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        // surface = white in light, dark card in dark mode.
        color: cs.surface,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            // Shadow visible in light only; border handles dark depth.
            color: isLight
                ? Colors.black.withOpacity(0.03)
                : Colors.transparent,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: isLight
            ? null
            : Border.all(color: cs.outline, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          SvgPicture.asset(assetPath, width: 60.r, height: 60.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                // Migrated from frozen font20BoldShadowPurple global.
                Text(
                  notification.title,
                  style: AppTextStyles.font20BoldShadowPurple(context).copyWith(
                    color: AppColors.primary,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                // Migrated from frozen font14RegularNightfall global.
                Text(
                  notification.body,
                  style: AppTextStyles.font14RegularNightfall(context).copyWith(
                    color: AppColors.ShadowPurple,
                  ),
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                ),
                if (notification.type == NotificationType.failure)
                  SizedBox(height: 8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
