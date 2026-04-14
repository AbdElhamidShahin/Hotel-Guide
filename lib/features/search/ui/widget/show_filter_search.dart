import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/search/ui/widget/price_range_filter.dart';

import '../../logic/cubit/search_cubit.dart';
import '../../logic/model.dart';

void showFilterSearch(
  BuildContext context, {
  required List<String> cities,
  required List<String> views,
}) {
  final searchCubit = context.read<SearchCubit>();
  FilterOptions tempFilter = FilterOptions();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.textWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              children: [
                _buildFilterHeader(context),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20.h),
                        _buildSectionTitle("السعر"),
                        SizedBox(height: 12.h),

                        Divider(
                          height: 1.h,
                          color: AppColors.primary.withOpacity(0.2),
                        ),

                        PriceRangeFilter(
                          initialValues: tempFilter.priceRange,
                          onChanged: (values) => tempFilter.priceRange = values,
                        ),

                        SizedBox(height: 24.h),
                        _buildSectionTitle("المدينة"),
                        SizedBox(height: 12.h),

                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          height: 1.h,
                        ),
                        SizedBox(height: 16.h),

                        _buildChoiceChips(
                          items: cities,
                          selectedItem: tempFilter.city,
                          onSelected: (val) =>
                              setModalState(() => tempFilter.city = val),
                        ),

                        SizedBox(height: 24.h),
                        _buildSectionTitle("الإطلالة"),
                        SizedBox(height: 12.h),

                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          height: 1.h,
                        ),
                        SizedBox(height: 16.h),

                        _buildChoiceChips(
                          items: views,
                          selectedItem: tempFilter.view,
                          onSelected: (val) =>
                              setModalState(() => tempFilter.view = val),
                        ),

                        SizedBox(height: 24.h),
                        _buildSectionTitle("التقييم"),
                        SizedBox(height: 12.h),

                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          height: 1.h,
                        ),
                        SizedBox(height: 16.h),

                        _buildRatingChips(
                          selectedRating: tempFilter.rating,
                          onSelected: (val) =>
                              setModalState(() => tempFilter.rating = val),
                        ),

                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 24.h, top: 12.h),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        onPressed: () {
                          searchCubit.applyFilter(tempFilter);
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("فلترة", style: textStyle16BoldWhite),
                            SizedBox(width: 8.w),
                            SvgPicture.asset(
                              "assets/icons/Filter_alt.svg",
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              width: 18.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: textStyle20BoldShadowPurple.copyWith(
      color: AppColors.primary,
      fontSize: 18.sp,
    ),
  );
}

Widget _buildChoiceChips({
  required List<String> items,
  String? selectedItem,
  required Function(String) onSelected,
}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: items.map((item) {
          bool isSelected = selectedItem == item;
          return Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: ChoiceChip(
              showCheckmark: false,
              label: Text(
                item,
                style: textStyle18BoldGray.copyWith(
                  color: isSelected ? Colors.white : AppColors.primary,
                  fontSize: 14.sp,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) => onSelected(item),
              selectedColor: AppColors.primary,
              backgroundColor: const Color(0xFFEBEBEB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

Widget _buildFilterHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w),
    height: 60.h,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
        ),
        const Spacer(),
        Text(
          "البحث المتقدم",
          style: textStyle16BoldWhite.copyWith(fontSize: 17.sp),
        ),
        SizedBox(width: 40.w),
        const Spacer(),
      ],
    ),
  );
}

Widget _buildRatingChips({
  double? selectedRating,
  required Function(double) onSelected,
}) {
  List<double> ratings = [1.0, 2.0, 3.0, 4.0, 5.0];

  return Directionality(
    textDirection: TextDirection.rtl,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: ratings.map((rate) {
          bool isSelected = selectedRating == rate;
          List<Widget> stars = [];
          for (int i = 0; i < rate.toInt(); i++) {
            stars.add(
              SvgPicture.asset(
                "assets/icons/rating/star-fill.svg",
                width: 16.w,
                height: 16.h,
              ),
            );
          }

          return Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: ChoiceChip(
              showCheckmark: false,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              label: Row(mainAxisSize: MainAxisSize.min, children: stars),
              selected: isSelected,
              onSelected: (val) => onSelected(rate),
              selectedColor: AppColors.primary,
              backgroundColor: const Color(0xFFEBEBEB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}
