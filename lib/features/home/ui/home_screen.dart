import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_appBar_home.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_city_home.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_offers_home.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_rating_listview.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_welcome_header.dart';
import 'package:hotel_guide/features/home/ui/widget/top_rating_widget.dart';

import '../../../core/theme/app_theme.dart';
import '../logic/cubit/home_cubit.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Divider(
                  height: 1,
                  color: AppColors.black.withOpacity(0.1),
                ),
              ),
              SizedBox(height: 16),

              TopRatingWidget(),
              SizedBox(height: 24),
              Builder(
                builder: (context) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<HotelsCubit>().fetchHotelsByCity(2);
                  });
                  return SizedBox(height: 380, child: CustomRatingListview());
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "الوجهات الرائجة",
                  style: textStyle23SemiBoldBlack.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(height: 12),

              CustomCityHome(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "عروض",
                  style: textStyle20RegularWhite.copyWith(
                    color: AppColors.black4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
