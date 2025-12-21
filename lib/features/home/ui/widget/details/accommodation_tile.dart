import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class AccommodationCard extends StatelessWidget {
  final String price;
  final String address;

  const AccommodationCard({
    Key? key,
    required this.price,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  address,
                  style: textStyle18BoldGray.copyWith(color: AppColors.primary),
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(width: 6.w),
              SvgPicture.asset(
                "assets/icons/location.svg",
                width: 24.w,
                height: 24.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
