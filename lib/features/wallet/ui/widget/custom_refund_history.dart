import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import 'custom_detail_row.dart';

class CustomRefundHistory extends StatelessWidget {
  const CustomRefundHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.w, top: 50.h, bottom: 6.h),
          child: Text(
            "اليوم",
            style: textStyle16BoldWhite.copyWith(color: AppColors.primary),
          ),
        ),
        SizedBox(height: 50.h,),
        Center(
          child: Text(
            "لا يوجد عمليات استرداد ",
            style: textStyle36BoldWhite.copyWith(color: AppColors.primary,fontSize:24 ),
          ),
        ),
      ],
    );
  }
}
