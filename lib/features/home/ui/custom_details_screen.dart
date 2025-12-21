import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/details/accommodation_tile.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_app_bar_details.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_list_view_imageall.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_service_details.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_service_details_list_view.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_name_details.dart';
import 'package:hotel_guide/features/home/ui/widget/details/divider.dart';
import 'package:hotel_guide/features/home/ui/widget/details/show_hotel_description.dart';

import '../../../core/network/hotel_model.dart';

class CustomDetailsScreen extends StatelessWidget {
  const CustomDetailsScreen({super.key, required this.hotelModel});
  final HotelModel hotelModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAppBarDetails(title: hotelModel.name),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    hotelModel.imageUrl,
                    width: double.infinity,
                    height: 230,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const CustomServiceDetailsListView(),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomNameDetails(name: hotelModel.name),
              ),

              AccommodationCard(
                address: hotelModel.location,
                price: hotelModel.price,
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: Text(
                  hotelModel.description,
                  maxLines: 9,
                  textDirection: TextDirection.rtl,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle1Regularprimary.copyWith(
                    color: AppColors.ShadowPurple,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => showHotelDescription(
                      context,
                      hotelModel.description,
                      hotelModel.name,
                    ),
                    child: Text(
                      "شاهد المزيد ",
                      textAlign: TextAlign.center,
                      style: textStyle18BoldGray.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              DividerWidget(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "صور الفندق",
                  style: TextStyle(
                    color: AppColors.black7,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: 16,
                  ),
                ),
              ),
              //
              SizedBox(height: 12),
              CustomListViewImageAll(hotelModel: hotelModel),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
