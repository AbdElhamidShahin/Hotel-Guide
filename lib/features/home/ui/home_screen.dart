import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/network/hotel_bloc.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/home/ai_booking_banner.dart';
import 'package:hotel_guide/features/home/ui/widget/home/booking_search_form.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_appBar_home.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_city_home.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_offers_home.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_rating_listview.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_welcome_header.dart';
import 'package:hotel_guide/features/home/ui/widget/top_rating_widget.dart';

import '../../../core/theme/app_theme.dart';
import '../logic/cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.name});
  final String name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getHotelsAndCities();
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
              SizedBox(height: 16),
              CustomWelcomeHeader(name: widget.name),
              SizedBox(height: 14),
              AiBookingBanner(),

              // SizedBox(height: 24),
              // BookingSearchForm(),
              SizedBox(height: 24),

              TopRatingWidget(name: 'الأكثر حجزًا هذا الأسبوع', onTap: () {}),

              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Divider(
                  height: 2,
                  color: AppColors.black.withOpacity(0.1),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                height: 440,
                child: CustomRatingListview(
                  cityId: "8a7ee754-037c-4a87-bda6-8a61527982a3",
                ),
              ),

              TopRatingWidget(
                name: 'إستكشف مصر',
                onTap: () {
                  final homeCubit = context.read<HomeCubit>();

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => BlocProvider.value(
                      value: homeCubit,
                      child: DraggableScrollableSheet(
                        expand: false,
                        initialChildSize: 0.9,
                        builder: (_, scrollController) => SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
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
                                ),
                              ),
                              const Divider(),
                              SizedBox(height: 16.h),
                              CustomCityHome(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Divider(
                  height: 2,
                  color: AppColors.black.withOpacity(0.1),
                ),
              ),
              SizedBox(height: 12),

              SizedBox(
                child: SingleChildScrollView(
                  child: CustomCityHome(itemCount: 4),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "!عروض ترويجية وخصومات وعروض خاصة لك",
                  style: textStyle14SemiBoldWhite.copyWith(
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
              ),
              SizedBox(height: 12),

              CustomOffersHome(),
            ],
          ),
        ),
      ),
    );
  }
}
