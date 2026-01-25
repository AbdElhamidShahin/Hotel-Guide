import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

class CustomRoomsListViewItem extends StatelessWidget {
  const CustomRoomsListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        context.go(routes.CustomRoom);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.asset(
              height: 300.h,
              width: 220.w,
              "assets/images/1686f7773fafd4ad2711763e02dd037e6522c12a.jpg",
              fit: BoxFit.cover,
            ),
            Container(
              height: 300.h,
              width: 220.w,
              color: AppColors.black.withOpacity(0.2),
            ),
            Positioned(
              bottom: 12.w,
              right: 12.h,
              left: 12.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "غرفة سوبر لوكس بسريرين",
                  style: textStyle16BoldWhite,
                  maxLines: 2,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),

            Positioned(
              top: 12.h,
              left: 12.w,
              child: Row(
                children: [
                  Icon(
                    Icons.star_border_sharp,
                    size: 24,
                    color: AppColors.orangeGold,
                  ),

                  Text(
                    "4.6",
                    style: textStyle18BoldGray.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
