import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import '../../../../core/network/model/notification_model.dart';

class CustomItemNotification extends StatelessWidget {
  final NotificationModel notification;
  const CustomItemNotification({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    String assetPath;

    switch (notification.type) {
      case NotificationType.success:
        assetPath = 'assets/images/notification_statuses/success.svg';
        break;
      case NotificationType.failure:
        assetPath = 'assets/images/notification_statuses/Falier.svg';
        break;
      case NotificationType.reminder:
        assetPath = 'assets/images/notification_statuses/times.svg';
        break;
      case NotificationType.message:
        assetPath = 'assets/images/notification_statuses/Email.svg';
        break;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
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
                Text(
                  notification.title,
                  style: font20BoldShadowPurple.copyWith(
                    color: AppColors.primary,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.body,
                  style: font14RegularNightfall.copyWith(
                    color: AppColors.ShadowPurple,
                  ),
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                ),

                if (notification.type == NotificationType.failure) ...[
                  SizedBox(height: 8.h),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
