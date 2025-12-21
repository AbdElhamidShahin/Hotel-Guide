import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class CustomOffersHome extends StatelessWidget {
  const CustomOffersHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 153,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Offers.jpg',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 143.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'إكتشف العروض',
                      style: textStyle14SemiBoldWhite.copyWith(
                        color: AppColors.white,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'عروض نهاية العام',
                        style: textStyle20RegularWhite.copyWith(
                          color: AppColors.white.withOpacity(0.82),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'استمتع بآخر لحظات الصيف بخصم بنسبة 15% على الأقل.',
                        style: textStyle14SemiBoldWhite.copyWith(
                          color: AppColors.white.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 19),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
