import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';

import '../../../../../core/helpers/contact/build_error_widget.dart'
    show buildNoConnectionMiniWidget;
import '../../../../../core/network/city_model.dart';
import '../../../logic/cubit/home_cubit.dart';
import '../../../logic/cubit/home_state.dart';

class CustomCityHome extends StatelessWidget {
  const CustomCityHome({super.key});

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
              context.read<HomeCubit>().fetchInitialData();
            },
          );
        }

        if (state is HomeLoaded) {
          if (state.cities.isEmpty) {
            return const Center(child: Text("لا توجد مدن حالياً"));
          }

          return Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: state.cities.length,
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
                      context.read<HomeCubit>().updateSelectedCity(city.id);

                      context.go(routes.cityHotelsScreen, extra: city);
                    },
                  );
                },
              ),

              const Divider(height: 30),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17),
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

              Container(color: Colors.black.withOpacity(0.4)),

              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Center(
                  child: Text(
                    city.name,
                    style: textStyle22BoldPrimary.copyWith(fontSize: 20.sp),
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
