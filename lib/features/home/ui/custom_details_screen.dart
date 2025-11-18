import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/accommodation_tile.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_app_bar_details.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_list_view_imageall.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_service_details.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomServiceDetails(
                        text: hotelModel.rating,
                        icon: Icons.star,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 12),
                      CustomServiceDetails(
                        text: hotelModel.breakfast,
                        icon: Icons.coffee_outlined,
                      ),
                      SizedBox(width: 12),
                      CustomServiceDetails(
                        text: hotelModel.isWifi,
                        icon: Icons.wifi,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              AccommodationCard(
                address: hotelModel.location,
                name: hotelModel.name,
                price: hotelModel.price,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  height: 1,
                  color: AppColors.black.withOpacity(0.1),
                ),
              ),
              SizedBox(height: 16),
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "الوصف",
                  style: TextStyle(
                    color: AppColors.black7,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8),
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  hotelModel.description,
                  maxLines: 4,
                  textDirection: TextDirection.rtl,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle15MediumGray.copyWith(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
          
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
              CustomListViewImageAll(hotelModel: hotelModel,),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}
