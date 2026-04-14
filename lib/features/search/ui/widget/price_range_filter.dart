import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 24.h),
        Text(
          "متوسط السعر",
          style: textStyle14RegularNightfall.copyWith(
            color: AppColors.primary.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 24.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPriceBox("الى", _currentRangeValues.end),
            SizedBox(width: 16.w),
            _buildPriceBox("من", _currentRangeValues.start),
          ],
        ),

        SizedBox(height: 30.h),

        LayoutBuilder(
          builder: (context, constraints) {
            double paddingHorizontal = 24.w;
            double availableWidth =
                constraints.maxWidth - (paddingHorizontal * 2);
            double startPos =
                (_currentRangeValues.start / 5000) * availableWidth;
            double endPos = (_currentRangeValues.end / 5000) * availableWidth;

            return Column(
              children: [
                Container(
                  height: 25.h,
                  margin: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: startPos - 15,
                        bottom: 0,
                        child: Text(
                          "${_currentRangeValues.start.round()}",
                          style: textStyle12SemiBoldShadowPurple,
                        ),
                      ),
                      Positioned(
                        left: endPos - 15,
                        bottom: 0,
                        child: Text(
                          "${_currentRangeValues.end.round()}",
                          style: textStyle12SemiBoldShadowPurple,
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
                  activeColor: Color(0xFF575472),
                  inactiveColor: Color(0xFF717375),
                  onChanged: (RangeValues values) {
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

  Widget _buildPriceBox(String label, double value) {
    return Container(
      width: 160.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: const Color(0xFFD0D5DD), width: 1.5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${value.round()} EGP ",
              style: textStyle18BoldGray.copyWith(fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),
            Text(
              ": $label",
              style: textStyle14RegularNightfall.copyWith(
                color: AppColors.pureBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
