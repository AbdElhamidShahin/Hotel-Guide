import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/colors.dart';

import '../../../../core/theme/app_theme.dart';

class CustomRatingListviewItem extends StatelessWidget {
  const CustomRatingListviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 15,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/test.png",
                          width: double.infinity,
                          height: 230,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
,
                  Positioned(
                    bottom: 30,
                    right: 25,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'مفتوح الآن',
                        style: textStyle14SemiBoldWhite,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 25,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 24,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '4.8',
                            style: textStyle16mediumWhite.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'هلنان رويال - حدائق المنتزه',
                      style: textStyle22RegularWhite.copyWith(
                        color: AppColors.black4,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF2F2F2),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('\$2000', style: textStyle28MediumBlack),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
