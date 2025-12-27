import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/core/helpers/widget/custom_item.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import '../../../logic/cubit/home_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSimilarHotelsListview extends StatefulWidget {
  final int cityId;
  const CustomSimilarHotelsListview({super.key, required this.cityId});

  @override
  State<CustomSimilarHotelsListview> createState() =>
      _CustomSimilarHotelsListviewState();
}

class _CustomSimilarHotelsListviewState
    extends State<CustomSimilarHotelsListview> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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

          if (specificCityHotels.isEmpty) return const SizedBox.shrink();

          return Column(
            children: [
              SizedBox(
                height: 250.h,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: specificCityHotels.length,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: CustomItem(
                        hotelModel: specificCityHotels[index],
                        isContinar: false,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  specificCityHotels.length,
                  (index) => buildDot(index),
                ).reversed.toList(),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: _currentPage == index ? 22.w : 8.w,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? const Color(0xFF2D2D44)
            : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
