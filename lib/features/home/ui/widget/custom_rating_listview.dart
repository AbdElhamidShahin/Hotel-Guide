import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/home_cubit.dart';
import '../../logic/cubit/home_state.dart';
import 'custom_rating_listview_item.dart';

class CustomRatingListview extends StatelessWidget {
  const CustomRatingListview({super.key, required this.cityId});
  final String cityId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, curr) =>
          curr is HomeLoading || curr is HomeLoaded || curr is HomeError,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          return Center(child: Text('خطأ: ${state.message}'));
        }

        if (state is HomeLoaded) {
          final cityName = state.cities
              .where((c) => c.id == cityId)
              .map((c) => c.name)
              .firstOrNull;

          if (cityName == null) {
            return const Center(child: Text('لا توجد بيانات للمدينة'));
          }

          final hotels = state.hotels
              .where((h) => h.cityName == cityName)
              .toList(growable: false);

          if (hotels.isEmpty) {
            return const Center(
              child: Text('لا توجد فنادق لهذه المدينة حالياً'),
            );
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hotels.length,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: true,
            itemBuilder: (context, index) =>
                CustomRatingListviewItem(hotelModel: hotels[index]),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
