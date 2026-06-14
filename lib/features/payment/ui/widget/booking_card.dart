

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/network/model/room_model.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';

class BookingCard extends StatelessWidget {
  final Room room;

  const BookingCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Theme.of(context).colorScheme.outline, width: 0.5),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: room.gallery.isNotEmpty
                  ? Image.network(
                room.gallery[0],
                width: 100.w,
                height: 100.w,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                "assets/images/onBoardingImage.jpg",
                width: 100.w,
                height: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    style: AppTextStyles.font16MediumWhite(context).copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.king_bed_outlined,
                        size: 18.sp,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        room.bedType ?? "غرفة مميزة",
                        style: AppTextStyles.font14RegularNightfall(context).copyWith(
                          color: Theme.of(context).textTheme.labelLarge?.color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.font16BoldWhite(context).copyWith(
                        color: AppColors.primary,
                      ),
                      children: [
                        const TextSpan(text: "السعر "),
                        TextSpan(
                          text: "${room.price} EGP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        const TextSpan(text: " / الليلة"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}