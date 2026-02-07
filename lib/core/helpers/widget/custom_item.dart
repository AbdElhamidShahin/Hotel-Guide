import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:snackly/snackly.dart';
import 'package:go_router/go_router.dart';

import '../../network/model/hotel_model.dart';
import '../../router/routers.dart';
import '../../theme/colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final favoriteCubit = context.read<FavoriteCubit>();
        final isCurrentlyFavorite = favoriteCubit.isFavorite(hotelModel);

        return Container(
          height: 250.h,
          margin: EdgeInsets.only(bottom: 8.h, left: 8.w, right: 8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () =>
                context.go(routes.customDetailsScreen, extra: hotelModel),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
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
                          hotelModel.images[0],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey[200],
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
                              title: isCurrentlyFavorite
                                  ? "تم الحذف"
                                  : "تمت الإضافة",
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
                              isCurrentlyFavorite
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

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
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: textStyle16BoldWhite.copyWith(
                            color: AppColors.ShadowPurple,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          hotelModel.description ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: textStyle14RegularNightfall.copyWith(
                            color: AppColors.ShadowPurple.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          maxLines: 2,

                          textDirection: TextDirection.rtl,
                          "يبدأ من ${hotelModel.priceStartsFrom} EGP /\nاليوم",
                          style: textStyle16BoldWhite.copyWith(
                            color: AppColors.colorText,
                          ),
                        ),

                        SizedBox(height: 8.h),
                        GestureDetector(
                          onTap: () {
                            context.go(
                              routes.customDetailsScreen,
                              extra: hotelModel,
                            );
                          },
                          child: Container(
                            height: 45.h,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              textDirection: TextDirection.rtl,
                              children: [
                                Text(
                                  "إحجز الآن",
                                  style: textStyle16BoldWhite.copyWith(
                                    fontSize: 16.sp,
                                    fontFamily: 'Cairo',
                                  ),
                                ),

                                SizedBox(width: 24.w),
                                SvgPicture.asset(
                                  "assets/icons/send.svg",
                                  height: 24.h,
                                  width: 24.w,
                                  color: Colors.white,
                                ),
                              ],
                            ),
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
