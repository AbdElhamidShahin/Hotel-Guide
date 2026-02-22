import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_state.dart';

import 'custom_rating_listview_item.dart';


class CustomRatingListview extends StatelessWidget {
  final String cityId;
  const CustomRatingListview({super.key, required this.cityId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeLoaded) {
          try {
            final specificCityHotels = state.hotels
                .where(
                  (hotel) =>
                      hotel.cityName ==
                      state.cities.firstWhere((c) => c.id == cityId).name,
                )
                .toList();

            if (specificCityHotels.isEmpty) {
              return const Center(
                child: Text("لا توجد فنادق لهذه المدينة حالياً"),
              );
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specificCityHotels.length,
              itemBuilder: (context, index) =>
                  CustomRatingListviewItem(hotelModel: specificCityHotels[index],),
            );
          } catch (e) {
            return const Center(child: Text("خطأ في عرض بيانات المدينة"));
          }
        }

        if (state is HomeError) {
          return Center(child: Text("خطأ: ${state.message}"));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
