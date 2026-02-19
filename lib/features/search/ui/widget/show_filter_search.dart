import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              children: [
                _buildFilterHeader(context),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20.h),
                        _buildSectionTitle("السعر"),
                        Divider(
                          height: 1,
                          color: AppColors.primary.withOpacity(0.2),
                        ),
                        PriceRangeFilter(
                          initialValues: tempFilter.priceRange,
                          onChanged: (values) => tempFilter.priceRange = values,
                        ),

                        _buildSectionTitle("المدينة"),
                        _buildChoiceChips(
                          items: cities,
                          selectedItem: tempFilter.city,
                          onSelected: (val) =>
                              setModalState(() => tempFilter.city = val),
                        ),

                        _buildSectionTitle("الإطلالة"),
                        _buildChoiceChips(
                          items: views,
                          selectedItem: tempFilter.view,
                          onSelected: (val) =>
                              setModalState(() => tempFilter.view = val),
                        ),

                        _buildSectionTitle("التقييم"),
                        _buildRatingChips(
                          selectedRating: tempFilter.rating,
                          onSelected: (val) =>
                              setModalState(() => tempFilter.rating = val),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      searchCubit.applyFilter(tempFilter);
                      Navigator.pop(context);
                    },
                    child: Text("تطبيق الفلتر", style: textStyle16BoldWhite),
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
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12.h),
    child: Text(title, style: textStyle18BoldGray),
  );
}

Widget _buildChoiceChips({
  required List<String> items,
  String? selectedItem,
  required Function(String) onSelected,
}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Wrap(
      spacing: 8.w,
      children: items.map((item) {
        bool isSelected = selectedItem == item;
        return ChoiceChip(
          label: Text(item),
          selected: isSelected,
          onSelected: (selected) => onSelected(item),
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
          backgroundColor: Colors.grey[200],
        );
      }).toList(),
    ),
  );
}

Widget _buildFilterHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    height: 68.h,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        const Spacer(),
        Text(
          "البحث المتقدم",
          style: textStyle16BoldWhite.copyWith(fontSize: 17.sp),
        ),
      ],
    ),
  );
}

Widget _buildRatingChips({
  double? selectedRating,
  required Function(double) onSelected,
}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Wrap(
      spacing: 8.w,
      children: [5.0, 4.0, 3.0, 2.0, 1.0].map((rate) {
        bool isSelected = selectedRating == rate;
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$rate"),
              const Icon(Icons.star, size: 14, color: Colors.amber),
            ],
          ),
          selected: isSelected,
          onSelected: (val) => onSelected(rate),
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    ),
  );
}
