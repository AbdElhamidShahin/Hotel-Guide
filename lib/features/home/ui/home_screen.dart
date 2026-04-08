import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/core/helpers/widget/custom_item.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/home/ai_booking_banner.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_appBar_home.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_city_home.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_offers_home.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_rating_listview.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_welcome_header.dart';
import 'package:hotel_guide/features/home/ui/widget/home/show_cities_bottom_sheet.dart';
import 'package:hotel_guide/features/home/ui/widget/home/show_hotels_bottom_sheet.dart';
import 'package:hotel_guide/features/home/ui/widget/top_rating_widget.dart';

import '../../../core/di/injection.dart';
import '../../../core/helpers/local_storage_account.dart';
import '../../../core/theme/app_theme.dart';
import '../../favorite/logic/cubit/favorite_cubit.dart';
import '../logic/cubit/home_cubit.dart';
import '../logic/cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.name});
  final String name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? displayUserName;

  @override
  void initState() {
    super.initState();
    _setupName();
    context.read<HomeCubit>().getHotelsAndCities();
  }

  Future<void> _setupName() async {
    if (widget.name.isNotEmpty) {
      setState(() {
        displayUserName = widget.name;
      });
    } else {
      final data = await UserDataManager.loadUserData();
      setState(() {
        displayUserName = data['name'] ?? 'ضيف';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAppbarHome(),
              SizedBox(height: 16.h),
              CustomWelcomeHeader(name: displayUserName ?? ''),
              SizedBox(height: 14.h),
              AiBookingBanner(),

              // SizedBox(height: 24),
              // BookingSearchForm(),
              SizedBox(height: 24.h),
              TopRatingWidget(
                name: 'الأكثر حجزًا هذا الأسبوع',
                onTap: () => showHotelsBottomSheet(context),
              ),

              SizedBox(height: 16.h),
              _buildDivider(),

              SizedBox(height: 24.h),
              SizedBox(
                height: 360.h,
                child: CustomRatingListview(
                  cityId: "8a7ee754-037c-4a87-bda6-8a61527982a3",
                ),
              ),
              SizedBox(height: 16.h),

              TopRatingWidget(
                name: 'إستكشف مصر',
                onTap: () => showCitiesBottomSheet(context),
              ),
              SizedBox(height: 16.h),

              _buildDivider(),
              SizedBox(height: 12.h),

              const CustomCityHome(itemCount: 4),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "!عروض ترويجية وخصومات وعروض خاصة لك",
                  style: textStyle14SemiBoldWhite.copyWith(
                    color: AppColors.black.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: 12.h),
              CustomOffersHome(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDivider() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Divider(
      height: 2.h,
      thickness: 1.h,
      color: AppColors.black.withOpacity(0.1),
    ),
  );
}
