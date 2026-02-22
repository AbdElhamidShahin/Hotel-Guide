import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import '../../../../../core/helpers/contact/build_error_widget.dart';
import '../../../../../core/network/model/city_model.dart';
import '../../../logic/cubit/home_cubit.dart';
import '../../../logic/cubit/home_state.dart';

class CustomCityHome extends StatelessWidget {
  const CustomCityHome({super.key, this.itemCount});
  final int? itemCount;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          return buildNoConnectionMiniWidget(
            onRetry: () {
              context.read<HomeCubit>().getHotelsAndCities();
            },
          );
        }

        if (state is HomeLoaded) {
          if (state.cities.isEmpty) {
            return const Center(child: Text("لا توجد مدن حالياً"));
          }
          final int displayCount = itemCount != null
              ? min(itemCount!, state.cities.length)
              : state.cities.length;
          return Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: displayCount,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final city = state.cities[index];
                  return CustomCityHomeItem(
                    city: city,
                    onTap: () {
                      final cityHotels = state.hotels
                          .where((h) => h.cityName == city.name)
                          .toList();
                      context.push(
                        routes.cityHotelsScreen,
                        extra: {'city': city, 'hotels': cityHotels},
                      );
                    },
                  );
                },
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class CustomCityHomeItem extends StatelessWidget {
  const CustomCityHomeItem({super.key, required this.city, this.onTap});

  final CityModel city;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Stack(
          children: [
            // Image
            Positioned.fill(
              child: Image.network(
                city.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Text(
                  city.name,
                  style: textStyle22BoldPrimary.copyWith(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
