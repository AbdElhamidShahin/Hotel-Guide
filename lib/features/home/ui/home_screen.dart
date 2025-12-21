import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/home/ai_booking_banner.dart';
import 'package:hotel_guide/features/home/ui/widget/home/booking_search_form.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_appBar_home.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_city_home.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_offers_home.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_rating_listview.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_welcome_header.dart';
import 'package:hotel_guide/features/home/ui/widget/top_rating_widget.dart';

import '../../../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAppbarHome(),
              SizedBox(height: 16),
              CustomWelcomeHeader(name: name),
              SizedBox(height: 14),
              AiBookingBanner(),
              SizedBox(height: 24),
              BookingSearchForm(),

              SizedBox(height: 24),

              TopRatingWidget(name: 'الأكثر حجزًا هذا الأسبوع'),
              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Divider(
                  height: 2,
                  color: AppColors.black.withOpacity(0.1),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(height: 440, child: CustomRatingListview()),
              TopRatingWidget(name: 'إستكشف مصر'),
              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Divider(
                  height: 2,
                  color: AppColors.black.withOpacity(0.1),
                ),
              ),
              SizedBox(height: 12),

              CustomCityHome(),


              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "!عروض ترويجية وخصومات وعروض خاصة لك",
                  style: textStyle14SemiBoldWhite.copyWith(
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
              ),
              SizedBox(height: 12),

              CustomOffersHome(),
            ],
          ),
        ),
      ),
    );
  }
}
