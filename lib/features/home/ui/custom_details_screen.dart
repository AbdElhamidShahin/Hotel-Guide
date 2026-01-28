import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_rating_listview.dart';
import 'package:hotel_guide/features/home/ui/widget/details/accommodation_tile.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_app_bar_details.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_list_view_imageall.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_rooms_and_location_details_screen.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_service_details.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_service_details_list_view.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_name_details.dart';
import 'package:hotel_guide/features/home/ui/widget/details/divider.dart';
import 'package:hotel_guide/features/home/ui/widget/details/rating_screen.dart';
import 'package:hotel_guide/features/home/ui/widget/details/show_hotel_description.dart';

import '../../../core/helpers/widget/custom_item.dart';
import '../../../core/network/hotel_model.dart';
import '../../../core/router/routers.dart';
import '../logic/cubit/home_cubit.dart';

class CustomDetailsScreen extends StatefulWidget {
  const CustomDetailsScreen({super.key, required this.hotelModel});
  final HotelModel hotelModel;

  @override
  State<CustomDetailsScreen> createState() => _CustomDetailsScreenState();
}

class _CustomDetailsScreenState extends State<CustomDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAppBarDetails(title: widget.hotelModel.name),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.hotelModel.imageUrl,
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
                child: CustomNameDetails(name: widget.hotelModel.name),
              ),

              AccommodationCard(
                address: widget.hotelModel.location,
                price: widget.hotelModel.price,
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: Text(
                  widget.hotelModel.description,
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
                      widget.hotelModel.description,
                      widget.hotelModel.name,
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

              SizedBox(
                height: 150.h,
                child: Center(child: RatingScreen()),
              ),

              SizedBox(height: 12.h),
              CustomRoomsAndLocationDetailsScreen(),
              SizedBox(height: 150.h),
              Center(
                child: Text(
                  "فنادق مشابهة",
                  style: textStyle22BoldPrimary.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 50.h),

              SizedBox(
                height: 300.h,
                width: double.infinity,
                child: GestureDetector(

                    onTap: () {
                      context.go(routes.customDetailsScreen, extra: widget.hotelModel);
                    },
                    child: CustomSimilarHotelsListview(cityId: 1)),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
