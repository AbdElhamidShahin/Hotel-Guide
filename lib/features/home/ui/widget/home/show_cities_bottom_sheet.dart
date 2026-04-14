import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../logic/cubit/home_cubit.dart';
import 'custom_city_home.dart';

void showCitiesBottomSheet(BuildContext context) {
  final homeCubit = context.read<HomeCubit>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => BlocProvider.value(
      value: homeCubit,
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        builder: (_, scrollController) => Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              height: 5.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            Text(
              "جميع المدن",
              style: textStyle1Regularprimary.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
            const Divider(),
            Expanded(child: CustomCityHome()),
          ],
        ),
      ),
    ),
  );
}
