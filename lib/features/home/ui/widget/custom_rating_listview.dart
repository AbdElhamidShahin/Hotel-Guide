import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import 'package:provider/provider.dart';

import '../../../../core/helpers/contact/build_error_widget.dart';
import '../../../../core/helpers/favorite_manger.dart';
import '../../../../core/network/hotel_model.dart';
import '../../../../core/router/routers.dart';
import '../../logic/cubit/home_state.dart';
import 'custom_rating_listview_item.dart';

class CustomRatingListview extends StatefulWidget {
  final int cityId;
  const CustomRatingListview({super.key, required this.cityId});

  @override
  State<CustomRatingListview> createState() => _CustomRatingListviewState();
}

class _CustomRatingListviewState extends State<CustomRatingListview> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        if (state is HomeLoaded) {
          final specificCityHotels = state.cities
              .firstWhere(
                (city) => city.id == widget.cityId,
                orElse: () => state.cities[0],
              )
              .hotels;

          if (specificCityHotels.isEmpty) {
            return const Center(child: Text("لا توجد فنادق حالياً"));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: specificCityHotels.length,
            itemBuilder: (context, index) {
              return CustomRatingListviewItem(
                hotelModel: specificCityHotels[index],
              );
            },
          );
        }
        if (state is HomeError) {
          return buildNoConnectionMiniWidget(
            onRetry: () {
              context.read<HomeCubit>().fetchInitialData();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
