import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class AccommodationCard extends StatelessWidget {
  final String name;
  final String price;
  final String address;

  const AccommodationCard({
    Key? key,
    required this.name,
    required this.price,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("EGP ${price}", style: textStyle18BoldGray),
              Text(
                "/day",
                style: textStyle18BoldGray.copyWith(
                  color: AppColors.gray3.withOpacity(0.6),
                ),
              ),
              Spacer(),
              Text(
                name,
                style: textStyle23SemiBoldBlack.copyWith(
                  fontSize: 20,
                  color: AppColors.black7,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),

          const SizedBox(height: 20.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 20.0,
                color: Colors.grey,
              ),
              const SizedBox(width: 4.0),

              Expanded(
                child: Text(
                  address,
                  style: textStyle15MediumGray,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
