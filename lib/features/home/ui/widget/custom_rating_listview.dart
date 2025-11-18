import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import 'package:provider/provider.dart';

import '../../../../core/helpers/favorite_manger.dart';
import '../../../../core/network/hotel_model.dart';
import '../../../../core/router/routers.dart';
import '../../logic/cubit/home_state.dart';
import 'custom_rating_listview_item.dart';

class CustomRatingListview extends StatefulWidget {
  const CustomRatingListview({super.key});

  @override
  State<CustomRatingListview> createState() => _CustomRatingListviewState();
}

class _CustomRatingListviewState extends State<CustomRatingListview> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).fetchHotelsByCity(2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        if (state is CitiesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CitiesError) {
          return Center(child: Text("حدث خطأ: ${state.message}"));
        }

        if (state is HotelsLoaded) {
          if (state.hotels.isEmpty) {
            return const Center(child: Text("لا توجد فنادق لهذه المدينة"));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.hotels.length,
            itemBuilder: (context, index) {
              return CustomRatingListviewItem(
                hotelModel: state.hotels[index],
              );
            },
          );

        }

        return const Center(child: Text("يرجى اختيار مدينة"));
      },
    );
  }
}
