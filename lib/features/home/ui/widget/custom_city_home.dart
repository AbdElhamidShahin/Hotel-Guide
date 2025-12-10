import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/network/city_model.dart';
import 'package:hotel_guide/core/network/supabase_failure.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_state.dart';

class CustomCityHome extends StatefulWidget {
  const CustomCityHome({super.key});

  @override
  State<CustomCityHome> createState() => _CustomCityHomeState();
}

class _CustomCityHomeState extends State<CustomCityHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CitiesCubit>(context).fetchCities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, CityState>(
      builder: (context, state) {
        if (state is CitiesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CitiesError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 50, color: Colors.red),
                const SizedBox(height: 10),
                Text(
                  state.message,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CitiesCubit>(context).fetchCities();
                  },
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (state is CitiesLoaded) {
          if (state.cities.isEmpty) {
            return const Center(child: Text('لا توجد مدن متاحة'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                childAspectRatio: 200 / 140,

                mainAxisSpacing: 16,
                crossAxisSpacing: 20,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return CustomCityHomeItem(cityModel: state.cities[index]);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class CustomCityHomeItem extends StatelessWidget {
  const CustomCityHomeItem({super.key, required this.cityModel});
  final CityModel cityModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(routes.customItem, extra: cityModel.id);
      },
      child: Container(
        width: 200,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.black4.withOpacity(0.45),
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: cityModel.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),

              Positioned(
                right: 0,
                left: 0,
                bottom: 10,
                child: Center(
                  child: Text(
                    cityModel.name,
                    style: textStyle23SemiBoldBlack.copyWith(
                      color: AppColors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
