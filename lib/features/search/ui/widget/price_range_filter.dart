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
            Container(
              width: 150.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: const Color(0xFFD0D5DD), width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${_currentRangeValues.end.round()} EGP ",
                      style: textStyle18BoldGray.copyWith(fontSize: 16),
                    ),
                    Text(
                      ": الى",
                      style: textStyle14RegularNightfall.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16.w),

            Container(
              width: 150.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: const Color(0xFFD0D5DD), width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${_currentRangeValues.start.round()} EGP ",
                      style: textStyle18BoldGray.copyWith(fontSize: 16),
                    ),
                    Text(
                      ": من",
                      style: textStyle14RegularNightfall.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20.h),

        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 5000,
          divisions: 100,
          activeColor: const Color(0xFF5D5C8A),
          inactiveColor: Colors.grey[300],
          labels: RangeLabels(
            "${_currentRangeValues.start.round()} EGP",
            "${_currentRangeValues.end.round()} EGP",
          ),
          onChanged: (RangeValues values) {
            setState(() => _currentRangeValues = values);
            widget.onChanged(values);
          },
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${_currentRangeValues.start.round()}EGP",
                style: TextStyle(
                  color: const Color(0xFF5D5C8A),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${_currentRangeValues.end.round()}EGP",
                style: TextStyle(
                  color: const Color(0xFF5D5C8A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
