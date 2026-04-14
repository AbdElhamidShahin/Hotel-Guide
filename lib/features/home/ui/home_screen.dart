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

import '../../../core/helpers/local_storage_account.dart';
import '../../../core/theme/app_theme.dart';
import '../logic/cubit/home_cubit.dart';
import '../logic/cubit/home_state.dart';

// ✅ PERF FIX 1: Hardcoded city ID moved to a constant — no magic strings scattered around.
const String _featuredCityId = '8a7ee754-037c-4a87-bda6-8a61527982a3';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.name});
  final String name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _displayUserName;

  @override
  void initState() {
    super.initState();
    // ✅ PERF FIX 2: Only fetch if data not already loaded.
    //    Previous code fetched on every initState + didChangeDependencies = 2 API calls on start.
    final homeCubit = context.read<HomeCubit>();
    if (homeCubit.state is! HomeLoaded) {
      homeCubit.getHotelsAndCities();
    }

    UserDataNotifier.instance.addListener(_onUserDataChanged);
    UserDataNotifier.instance.load();
  }

  @override
  void dispose() {
    UserDataNotifier.instance.removeListener(_onUserDataChanged);
    super.dispose();
  }

  void _onUserDataChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final notifier = UserDataNotifier.instance;
    final displayName =
    notifier.name.isNotEmpty ? notifier.name : widget.name;

    return Scaffold(
      // ✅ PERF FIX 3: CustomScrollView with Slivers instead of SingleChildScrollView + Column.
      //    This allows lazy rendering — widgets off-screen are not built until needed.
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── App bar ───────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ✅ PERF FIX 4: const widgets — Flutter skips rebuilding these
                  const CustomAppbarHome(),
                  SizedBox(height: 16.h),
                  CustomWelcomeHeader(name: displayName),
                  SizedBox(height: 14.h),
                  const AiBookingBanner(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),

            // ── Most booked section ───────────────────────────────────────
            SliverToBoxAdapter(
              child: TopRatingWidget(
                name: 'الأكثر حجزًا هذا الأسبوع',
                onTap: () =>
                    showHotelsBottomSheet(context, 'الأكثر حجزًا هذا الأسبوع'),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
            const SliverToBoxAdapter(child: _SectionDivider()),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),

            // ── Hotel list (horizontal scroll) ────────────────────────────
            // ✅ PERF FIX 5: RepaintBoundary isolates this expensive list
            //    from rebuilds in surrounding widgets.
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: SizedBox(
                  height: 360.h,
                  child: CustomRatingListview(cityId: _featuredCityId),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 16.h)),

            // ── Explore Egypt section ─────────────────────────────────────
            SliverToBoxAdapter(
              child: TopRatingWidget(
                name: 'إستكشف مصر',
                onTap: () => showCitiesBottomSheet(context),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
            const SliverToBoxAdapter(child: _SectionDivider()),
            SliverToBoxAdapter(child: SizedBox(height: 12.h)),

            // ── Cities grid ───────────────────────────────────────────────
            const SliverToBoxAdapter(child: CustomCityHome(itemCount: 4)),

            SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  '!عروض ترويجية وخصومات وعروض خاصة لك',
                  style: textStyle14SemiBoldWhite.copyWith(
                    color: AppColors.black.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),

            // ── Offers section ────────────────────────────────────────────
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: GestureDetector(
                  onTap: () => showHotelsBottomSheet(context, 'عروض نهايه العام'),
                  child: const CustomOffersHome(),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          ],
        ),
      ),
    );
  }
}

/// ✅ ARCH FIX: Extracted reusable widget — was an inline function `_buildDivider()`.
///    Functions returning widgets prevent Flutter from optimizing rebuilds.
///    Stateless widget classes ARE properly cached by the framework.
class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Divider(
        height: 2.h,
        thickness: 1.h,
        color: AppColors.black.withOpacity(0.1),
      ),
    );
  }
}
