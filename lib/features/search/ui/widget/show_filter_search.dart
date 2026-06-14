import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
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
    // backgroundColor from BottomSheetThemeData in AppThemeData — adapts automatically.
    backgroundColor: Colors.transparent,
    builder: (context) {
      final cs      = Theme.of(context).colorScheme;
      final isLight = Theme.of(context).brightness == Brightness.light;

      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            decoration: BoxDecoration(
              // surface = white in light, dark card in dark mode.
              color: cs.surface,
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
                        _buildSectionTitle(context, 'السعر'),
                        SizedBox(height: 12.h),
                        Divider(height: 1.h, color: cs.outline),
                        PriceRangeFilter(
                          initialValues: tempFilter.priceRange,
                          onChanged: (v) => tempFilter.priceRange = v,
                        ),
                        SizedBox(height: 24.h),
                        _buildSectionTitle(context, 'المدينة'),
                        SizedBox(height: 12.h),
                        Divider(height: 1.h, color: cs.outline),
                        SizedBox(height: 16.h),
                        _buildChoiceChips(
                          context: context,
                          items: cities,
                          selectedItem: tempFilter.city,
                          onSelected: (v) =>
                              setModalState(() => tempFilter.city = v),
                        ),
                        SizedBox(height: 24.h),
                        _buildSectionTitle(context, 'الإطلالة'),
                        SizedBox(height: 12.h),
                        Divider(height: 1.h, color: cs.outline),
                        SizedBox(height: 16.h),
                        _buildChoiceChips(
                          context: context,
                          items: views,
                          selectedItem: tempFilter.view,
                          onSelected: (v) =>
                              setModalState(() => tempFilter.view = v),
                        ),
                        SizedBox(height: 24.h),
                        _buildSectionTitle(context, 'التقييم'),
                        SizedBox(height: 12.h),
                        Divider(height: 1.h, color: cs.outline),
                        SizedBox(height: 16.h),
                        _buildRatingChips(
                          context: context,
                          selectedRating: tempFilter.rating,
                          onSelected: (v) =>
                              setModalState(() => tempFilter.rating = v),
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
                            // Always white — on primary-colour button.
                            Text('فلترة',
                                style: AppTextStyles.font16BoldWhite(context)),
                            SizedBox(width: 8.w),
                            SvgPicture.asset(
                              'assets/icons/Filter_alt.svg',
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

// ── Section title ─────────────────────────────────────────────────────────────

Widget _buildSectionTitle(BuildContext context, String title) {
  return Text(
    title,
    // Migrated from frozen font20BoldShadowPurple global.
    style: AppTextStyles.font20BoldShadowPurple(context).copyWith(
      color: AppColors.primary,
      fontSize: 18.sp,
    ),
  );
}

// ── Choice chips ──────────────────────────────────────────────────────────────

Widget _buildChoiceChips({
  required BuildContext context,
  required List<String> items,
  String? selectedItem,
  required Function(String) onSelected,
}) {
  final cs = Theme.of(context).colorScheme;
  return Directionality(
    textDirection: TextDirection.rtl,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: items.map((item) {
          final bool isSelected = selectedItem == item;
          return Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: ChoiceChip(
              showCheckmark: false,
              label: Text(
                item,
                // Migrated from frozen font18BoldGray global.
                style: AppTextStyles.font18BoldGray(context).copyWith(
                  // Always white when selected (on primary chip), else themed.
                  color: isSelected ? Colors.white : cs.onSurfaceVariant,
                  fontSize: 14.sp,
                ),
              ),
              selected: isSelected,
              onSelected: (_) => onSelected(item),
              selectedColor: AppColors.primary,
              // surfaceContainerHighest = themed neutral chip background.
              backgroundColor: cs.surfaceContainerHighest,
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

// ── Filter header ─────────────────────────────────────────────────────────────
// Brand primary header — intentionally static in both themes.

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
          // Always white — on primary-colour header.
          icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
        ),
        const Spacer(),
        // Migrated from frozen font16BoldWhite global.
        Text(
          'البحث المتقدم',
          style: AppTextStyles.font16BoldWhite(context).copyWith(fontSize: 17.sp),
        ),
        SizedBox(width: 40.w),
        const Spacer(),
      ],
    ),
  );
}

// ── Rating chips ──────────────────────────────────────────────────────────────

Widget _buildRatingChips({
  required BuildContext context,
  double? selectedRating,
  required Function(double) onSelected,
}) {
  final cs = Theme.of(context).colorScheme;
  const List<double> ratings = [1.0, 2.0, 3.0, 4.0, 5.0];

  return Directionality(
    textDirection: TextDirection.rtl,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: ratings.map((rate) {
          final bool isSelected = selectedRating == rate;
          return Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: ChoiceChip(
              showCheckmark: false,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  rate.toInt(),
                  (_) => SvgPicture.asset(
                    'assets/icons/rating/star-fill.svg',
                    width: 16.w,
                    height: 16.h,
                  ),
                ),
              ),
              selected: isSelected,
              onSelected: (_) => onSelected(rate),
              selectedColor: AppColors.primary,
              backgroundColor: cs.surfaceContainerHighest,
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
