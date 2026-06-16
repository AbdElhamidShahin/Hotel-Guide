import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/features/home/ui/widget/details/accommodation_tile.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_app_bar_details.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_list_view_imageall.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_name_details.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_rooms_and_location_details_screen.dart';
import 'package:hotel_guide/features/home/ui/widget/details/custom_service_details_list_view.dart';
import 'package:hotel_guide/features/home/ui/widget/details/divider.dart';
import 'package:hotel_guide/features/home/ui/widget/details/rating_screen.dart';
import 'package:hotel_guide/features/home/ui/widget/details/show_hotel_description.dart';

import '../../../core/network/model/hotel_model.dart';
import '../../../core/theme/app_theme_data.dart';
import '../../../core/theme/colors.dart';

class CustomDetailsScreen extends StatelessWidget {
  const CustomDetailsScreen({super.key, required this.hotelModel});
  final HotelModel hotelModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor:
          colorScheme.surface, // لضمان تلون خلفية الشاشة بالكامل باللون الصحيح
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBarDetails(title: hotelModel.name),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 16.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.network(
                      hotelModel.images.isNotEmpty ? hotelModel.images[0] : '',
                      width: double.infinity,
                      height: 230.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  const CustomServiceDetailsListView(),
                  SizedBox(height: 20.h),

                  CustomNameDetails(name: hotelModel.name),
                  AccommodationCard(
                    address: hotelModel.address,
                    price: '${hotelModel.priceStartsFrom}',
                  ),
                  SizedBox(height: 16.h),

                  Text(
                    hotelModel.description,
                    maxLines: 4,
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font17RegularPrimary(context).copyWith(
                      // التعديل: قراءة لون النص الفرعي من الـ Theme ليتغير في الـ Dark Mode تلقائياً
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () => showHotelDescription(
                        context,
                        hotelModel.description,
                        hotelModel.name,
                      ),
                      child: Text(
                        'شاهد المزيد',
                        style: AppTextStyles.font18BoldGray(context).copyWith(
                          color: colorScheme
                              .primary, // قراءة لون الهوية من الـ Theme
                        ),
                      ),
                    ),
                  ),
                  const DividerWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: RatingScreen(hotelModel: hotelModel),
                  ),
                  CustomRoomsAndLocationDetailsScreen(hotelModel: hotelModel),

                  SizedBox(height: 40.h),
                ]),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'فنادق مشابهة',
                      style: AppTextStyles.font22BoldPrimary(context).copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomSimilarHotelsListview(
                    hotelModel: hotelModel,
                    cityId: 'e1d53167-c06b-410b-81dc-d5694a9f81dc',
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
