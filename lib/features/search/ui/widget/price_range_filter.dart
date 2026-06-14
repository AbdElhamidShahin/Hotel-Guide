import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme_data.dart';
import '../../../../core/theme/colors.dart';

class PriceRangeFilter extends StatefulWidget {
  final RangeValues initialValues;
  final ValueChanged<RangeValues> onChanged;

  const PriceRangeFilter({
    super.key,
    required this.initialValues,
    required this.onChanged,
  });

  @override
  State<PriceRangeFilter> createState() => _PriceRangeFilterState();
}

class _PriceRangeFilterState extends State<PriceRangeFilter> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = widget.initialValues;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 24.h),
        // Migrated from frozen font14RegularNightfall global.
        Text(
          'متوسط السعر',
          style: AppTextStyles.font14RegularNightfall(context).copyWith(
            color: AppColors.primary.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPriceBox(context, 'الى', _currentRangeValues.end),
            SizedBox(width: 16.w),
            _buildPriceBox(context, 'من', _currentRangeValues.start),
          ],
        ),
        SizedBox(height: 30.h),
        LayoutBuilder(
          builder: (context, constraints) {
            final double paddingH   = 24.w;
            final double available  = constraints.maxWidth - (paddingH * 2);
            final double startPos   = (_currentRangeValues.start / 5000) * available;
            final double endPos     = (_currentRangeValues.end   / 5000) * available;

            return Column(
              children: [
                Container(
                  height: 25.h,
                  margin: EdgeInsets.symmetric(horizontal: paddingH),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: startPos - 15,
                        bottom: 0,
                        // Migrated from frozen font12SemiBoldShadowPurpleled global.
                        child: Text(
                          '${_currentRangeValues.start.round()}',
                          style: AppTextStyles.font12SemiBoldShadowPurple(context),
                        ),
                      ),
                      Positioned(
                        left: endPos - 15,
                        bottom: 0,
                        child: Text(
                          '${_currentRangeValues.end.round()}',
                          style: AppTextStyles.font12SemiBoldShadowPurple(context),
                        ),
                      ),
                    ],
                  ),
                ),
                RangeSlider(
                  values: _currentRangeValues,
                  min: 0,
                  max: 5000,
                  divisions: 100,
                  // Brand colour — stays consistent in both themes.
                  activeColor: AppColors.ShadowPurple,
                  // outline = themed inactive track — lighter in light, darker in dark.
                  inactiveColor: cs.outline,
                  onChanged: (values) {
                    setState(() => _currentRangeValues = values);
                    widget.onChanged(values);
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildPriceBox(BuildContext context, String label, double value) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: 160.w,
      height: 50.h,
      decoration: BoxDecoration(
        // outline = themed border adapts in dark mode.
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: cs.outline, width: 1.5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Migrated from frozen font18BoldGray global.
            Text(
              '${value.round()} EGP ',
              style: AppTextStyles.font18BoldGray(context).copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Migrated from frozen font14RegularNightfall global.
            Text(
              ': $label',
              style: AppTextStyles.font14RegularNightfall(context),
            ),
          ],
        ),
      ),
    );
  }
}
