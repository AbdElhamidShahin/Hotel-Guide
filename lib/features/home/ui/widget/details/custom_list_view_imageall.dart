import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/helpers/widget/custom_item.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_state.dart';
import '../../../../../core/network/model/hotel_model.dart';

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
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeLoaded) {
          final similarHotels = _filterSimilarHotels(state);
          if (similarHotels.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHotelPageView(similarHotels),
              SizedBox(height: 16.h),
              _buildDotsIndicator(similarHotels.length),
            ],
          );
        }

        if (state is HomeError) {
          return Center(child: Text("خطأ: ${state.message}"));
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHotelPageView(List<HotelModel> hotels) {
    return SizedBox(
      height: 250.h,
      child: PageView.builder(
        controller: _pageController,
        itemCount: hotels.length,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (page) => setState(() => _currentPage = page),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: GestureDetector(
              onTap: () => context.push(
                routes.customDetailsScreen,
                extra: hotels[index],
              ),
              child: CustomItem(hotelModel: hotels[index], isContinar: false),
            ),
          );
        },
      ),
    );
  }

// تم اختصار التعديل داخل الـ Widget المسؤول عن الـ Dots فقط لعدم تكرار الملف الكلي:
  Widget _buildDotsIndicator(int count) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 6.r,
          width: _currentPage == index ? 16.w : 6.w,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? colorScheme.primary // قراءة ثيم البراند التكيفي
                : colorScheme.outlineVariant, // التعديل: لون رمادي متوافق مع الحالتين تلقائياً
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }).reversed.toList(),
    );
  }
  List<HotelModel> _filterSimilarHotels(HomeLoaded state) {
    try {
      final cityName = state.cities
          .firstWhere(
            (c) => c.id == widget.cityId,
            orElse: () => state.cities.first,
          )
          .name;
      return state.hotels
          .where((h) => h.cityName == cityName && h.id != widget.hotelModel.id)
          .toList();
    } catch (_) {
      return [];
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: const Text("لا توجد فنادق مشابهة حالياً"),
      ),
    );
  }
}
