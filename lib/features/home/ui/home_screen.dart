import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/features/home/ui/widget/home/ai_booking_banner.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_appBar_home.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_city_home.dart';
import 'package:hotel_guide/features/home/ui/widget/home/custom_offers_home.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_rating_listview.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_welcome_header.dart';
import 'package:hotel_guide/features/home/ui/widget/home/show_cities_bottom_sheet.dart';
import 'package:hotel_guide/features/home/ui/widget/home/show_hotels_bottom_sheet.dart';
import 'package:hotel_guide/features/home/ui/widget/top_rating_widget.dart';
import '../../../core/helpers/local_storage_account.dart';
import '../../../core/helpers/widget/section_divider.dart';
import '../../../core/theme/app_theme_data.dart';

const String _featuredCityId = '8a7ee754-037c-4a87-bda6-8a61527982a3';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final notifier = UserDataNotifier.instance;

    return Scaffold(
      body: ListenableBuilder(
        listenable: UserDataNotifier.instance,
        builder: (context, child) {
          final displayName = notifier.name.isNotEmpty ? notifier.name : name;

          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const CustomAppbarHome(),
                      SizedBox(height: 16.h),
                      CustomWelcomeHeader(name: displayName),
                      SizedBox(height: 14.h),
                      const AiBookingBanner(),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),

                SliverToBoxAdapter(
                  child: TopRatingWidget(
                    name: 'الأكثر حجزًا هذا الأسبوع',
                    onTap: () => showHotelsBottomSheet(
                      context,
                      'الأكثر حجزًا هذا الأسبوع',
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                const SliverToBoxAdapter(child: SectionDivider()),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                SliverToBoxAdapter(
                  child: RepaintBoundary(
                    child: SizedBox(
                      height: 360.h,
                      child: CustomRatingListview(cityId: _featuredCityId),
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                SliverToBoxAdapter(
                  child: TopRatingWidget(
                    name: 'إستكشف مصر',
                    onTap: () => showCitiesBottomSheet(context),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                const SliverToBoxAdapter(child: SectionDivider()),
                SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                const SliverToBoxAdapter(child: CustomCityHome(itemCount: 4)),

                SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      '!عروض ترويجية وخصومات وعروض خاصة لك',
                      style: AppTextStyles.font14SemiBoldWhite(context).copyWith(
                        color: Theme.of(context).colorScheme.onSurface
                            .withOpacity(0.6),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 12.h)),

                SliverToBoxAdapter(
                  child: RepaintBoundary(
                    child: GestureDetector(
                      onTap: () =>
                          showHotelsBottomSheet(context, 'عروض نهايه العام'),
                      child: const CustomOffersHome(),
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              ],
            ),
          );
        },
      ),
    );
  }
}
