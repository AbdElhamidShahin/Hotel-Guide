import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:snackly/snackly.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/model/hotel_model.dart';
import '../../../../core/router/routers.dart';
import '../../../favorite/logic/cubit/favorite_cubit.dart';
import '../../../favorite/logic/cubit/favorite_state.dart';

class CustomRatingListviewItem extends StatelessWidget {
  CustomRatingListviewItem({super.key, required this.hotelModel});
  final HotelModel hotelModel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return GestureDetector(
      onTap: () => context.push(routes.customDetailsScreen, extra: hotelModel),
      child: Container(
        width: 240.w,
        margin: EdgeInsetsDirectional.only(start: 16.w, bottom: 10.h),
        decoration: BoxDecoration(
          // surface = white in light, dark card in dark mode.
          color: cs.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              // Shadow fades out in dark mode; border below provides depth.
              color: isLight
                  ? Colors.black.withOpacity(0.08)
                  : Colors.transparent,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          // Subtle border replaces shadow in dark mode.
          border: isLight ? null : Border.all(color: cs.outline, width: 0.5),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: Image.network(
                      hotelModel.images[0],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: _buildFavoriteIcon(),
                  ),
                  Positioned(
                    bottom: 10.h,
                    left: 8.w,
                    child: _buildRatingBadge(context),
                  ),
                  Positioned(
                    bottom: 10.h,
                    right: 8.w,
                    child: _buildStatusBadge(context),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hotelModel.name,
                      // Migrated from font16BoldWhite.copyWith(color: pureBlack).
                      style: AppTextStyles.font16BoldWhite(
                        context,
                      ).copyWith(color: cs.onSurface),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Divider(height: 1, color: cs.outline),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/send.svg',
                          width: 20.r,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'إحجز الآن',
                          style: AppTextStyles.font17RegularPrimary(context)
                              .copyWith(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : AppColors.primary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteIcon() {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final favorites = state is FavoriteUpdated ? state.favorites : [];
        final isFavorite = favorites.any((h) => h.id == hotelModel.id);

        return IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: isFavorite ? Colors.red : Colors.white,
              size: 24.r,
            ),
          ),
          onPressed: () {
            context.read<FavoriteCubit>().toggleFavorite(hotelModel);
            final wasAdded = !isFavorite;
            Snackly.success(
              context: context,
              title: wasAdded
                  ? 'تم الإضافة إلى المفضلة'
                  : 'تم الحذف من المفضلة',
              style: SnackbarStyle.filled,
            );
          },
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(),
        );
      },
    );
  }

  Widget _buildRatingBadge(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star_rounded, color: Colors.amber, size: 24.r),
        Text(
          ' ${hotelModel.rating}',
          // Migrated from frozen font14SemiBoldWhite — always white, sits on photo.
          style: AppTextStyles.font14SemiBoldWhite(
            context,
          ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      // Always white — on green background regardless of theme.
      child: Text('إقتصادي', style: AppTextStyles.font14SemiBoldWhite(context)),
    );
  }
}
