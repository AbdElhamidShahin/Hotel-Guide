import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:snackly/snackly.dart';
import 'package:go_router/go_router.dart';
import '../../network/model/hotel_model.dart';
import '../../router/routers.dart';
import '../../../features/favorite/logic/cubit/favorite_cubit.dart';
import '../../../features/favorite/logic/cubit/favorite_state.dart';

class CustomItem extends StatelessWidget {
  final HotelModel hotelModel;
  final bool isContinar;

  const CustomItem({
    super.key,
    required this.hotelModel,
    required this.isContinar,
  });

  void _navigateToDetails(BuildContext context) {
    context.push(routes.customDetailsScreen, extra: hotelModel);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final favoriteCubit = context.read<FavoriteCubit>();
        final isCurrentlyFavorite = favoriteCubit.isFavorite(hotelModel);

        return Container(
          height: 250.h,
          margin: EdgeInsets.only(bottom: 8.h, left: 8.w, right: 8.w),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: colorScheme.brightness == Brightness.light
                    ? Colors.black.withOpacity(0.06)
                    : Colors.transparent,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () => _navigateToDetails(context),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                // جزء الصورة
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.r),
                          bottomRight: Radius.circular(12.r),
                        ),
                        child: Image.network(
                          hotelModel.images.isNotEmpty ? hotelModel.images[0] : '',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: colorScheme.surfaceContainerHighest,
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10.h,
                        right: 10.w,
                        child: GestureDetector(
                          onTap: () async {
                            await favoriteCubit.toggleFavorite(hotelModel);
                            Snackly.success(
                              context: context,
                              title: isCurrentlyFavorite ? 'تم الحذف' : 'تمت الإضافة',
                              style: SnackbarStyle.filled,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isCurrentlyFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // جزء التفاصيل
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          hotelModel.name.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font16BoldWhite(context).copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          hotelModel.description ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font14RegularNightfall(context).copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'يبدأ من ${hotelModel.priceStartsFrom} EGP / اليوم',
                          style: AppTextStyles.font16BoldWhite(context).copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                        const Spacer(),
                        // زر إحجز الآن
                        Container(
                          height: 45.h,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                'إحجز الآن',
                                style: TextStyle(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/send.svg',
                                height: 20.h,
                                width: 20.w,
                                colorFilter: ColorFilter.mode(colorScheme.onPrimary, BlendMode.srcIn),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}