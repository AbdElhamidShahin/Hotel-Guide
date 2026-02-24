import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:snackly/snackly.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/model/hotel_model.dart';
import '../../../../core/router/routers.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../../../favorite/logic/cubit/favorite_cubit.dart';
import '../../../favorite/logic/cubit/favorite_state.dart';

class CustomRatingListviewItem extends StatelessWidget {
  CustomRatingListviewItem({super.key, required this.hotelModel});
  final HotelModel hotelModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(routes.customDetailsScreen, extra: hotelModel),
      child: Container(
        width: 240.w,
        margin: EdgeInsetsDirectional.only(start: 16.w, bottom: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
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
                    child: _buildRatingBadge(),
                  ),
                  Positioned(
                    bottom: 10.h,
                    right: 8.w,
                    child: _buildStatusBadge(),
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
                      style: textStyle16BoldWhite.copyWith(
                        color: AppColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/send.svg",
                          width: 20.r,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 6.w),

                        Text("إحجز الآن", style: textStyle1Regularprimary),
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
    return BlocProvider.value(
      value: getIt<FavoriteCubit>(),

      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final favoriteCubit = context.read<FavoriteCubit>();
          final isFavorite = favoriteCubit.isFavorite(hotelModel);

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
            onPressed: () async {
              final bool currentlyFavorite = isFavorite;
              await favoriteCubit.toggleFavorite(hotelModel);

              if (currentlyFavorite) {
                Snackly.success(
                  context: context,
                  title: "تم الحذف من المفضلة",
                  style: SnackbarStyle.filled,
                );
              } else {
                Snackly.success(
                  context: context,
                  title: "تم الإضافة إلى المفضلة",
                  style: SnackbarStyle.filled,
                );
              }
            },
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          );
        },
      ),
    );


  }

  Widget _buildRatingBadge() {
    return Row(
      children: [
        Icon(Icons.star_rounded, color: Colors.amber, size: 24.r),
        Text(
          " ${hotelModel.rating}",
          style: textStyle14SemiBoldWhite.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text("إقتصادي", style: textStyle14SemiBoldWhite),
    );
  }
}
