import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/details/accommodation_tile.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_app_bar_details.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_list_view_imageall.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_rooms_and_location_details_screen.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_service_details_list_view.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_name_details.dart';
import 'package:hotel_guide/features/home/ui/widget/details/divider.dart';
import 'package:hotel_guide/features/home/ui/widget/details/rating_screen.dart';
import 'package:hotel_guide/features/home/ui/widget/details/show_hotel_description.dart';
import '../../../core/network/model/hotel_model.dart';
import '../../room/logic/room_cubit.dart';
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
    context.read<HomeCubit>().getHotelsAndCities();
    context.read<RoomCubit>().getRoomsHotel(widget.hotelModel.id);
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
                    widget.hotelModel.images[0],
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
                address: widget.hotelModel.address,
                price: "${widget.hotelModel.priceStartsFrom}",
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: Text(
                  widget.hotelModel.description,
                  maxLines: 9,
                  textDirection: TextDirection.rtl,
                  overflow: TextOverflow.ellipsis,
                  style: font17RegularPrimary.copyWith(
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
                      style: font18BoldGray.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              DividerWidget(),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: RatingScreen(hotelModel: widget.hotelModel),
              ),

              SizedBox(height: 16.h),
              CustomRoomsAndLocationDetailsScreen(
                hotelModel: widget.hotelModel,
              ),
              SizedBox(height: 50.h),
              Center(
                child: Text(
                  "فنادق مشابهة",
                  style: font22BoldPrimary.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              CustomSimilarHotelsListview(
                hotelModel: widget.hotelModel,
                cityId: 'e1d53167-c06b-410b-81dc-d5694a9f81dc',
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
