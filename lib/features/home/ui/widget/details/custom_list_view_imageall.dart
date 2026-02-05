import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/helpers/widget/custom_item.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import '../../../../../core/network/model/hotel.dart';
import '../../../logic/cubit/home_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSimilarHotelsListview extends StatefulWidget {
  final String cityId;
  final HotelModel hotelModel;
  const CustomSimilarHotelsListview({
    super.key,
    required this.cityId,
    required this.hotelModel,
  });

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

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: _currentPage == index ? 18.w : 8.w,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.purple : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        if (state is HomeLoading) {
          return SizedBox(
            height: 250.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeLoaded) {
          try {
            final specificCityHotels = state.hotels.where((hotel) {
              final cityName = state.cities
                  .firstWhere((c) => c.id == widget.cityId,
                  orElse: () => state.cities.first)
                  .name;
              return hotel.cityName == cityName &&
                  hotel.id != widget.hotelModel.id;
            }).toList();

            if (specificCityHotels.isEmpty) {
              return SizedBox(
                height: 100.h,
                child: const Center(
                  child: Text("لا توجد فنادق مشابهة في هذه المدينة"),
                ),
              );
            }

            return Column(
              children: [
                SizedBox(
                  height: 250.h,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: specificCityHotels.length,
                    reverse: true, // يدعم RTL
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.push(
                            routes.customDetailsScreen,
                            extra: specificCityHotels[index],
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: CustomItem(
                            hotelModel: specificCityHotels[index],
                            isContinar: false,
                          ),
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
          } catch (e) {
            return const Center(child: Text("خطأ في عرض بيانات الفنادق المشابهة"));
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