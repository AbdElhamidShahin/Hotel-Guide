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
      onTap: () {
        context.go(routes.customDetailsScreen, extra: hotelModel);
      },
      child: SizedBox(
        width: 320.h,
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Stack(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            hotelModel.images[0],
                            width: 320.h,
                            height: 300.h,

                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 20.h,
                      right: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'مفتوح الآن',
                          style: textStyle14SemiBoldWhite,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.h,
                      left: 20.w,
                      child: Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: BlocProvider.value(
                          value: getIt<FavoriteCubit>(),

                          child: BlocBuilder<FavoriteCubit, FavoriteState>(
                            builder: (context, state) {
                              final favoriteCubit = context
                                  .read<FavoriteCubit>();
                              final isFavorite = favoriteCubit.isFavorite(
                                hotelModel,
                              );

                              return IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border,
                                  color: isFavorite
                                      ? Colors.redAccent
                                      : Colors.white,
                                  size: 32,
                                ),
                                onPressed: () async {
                                  final bool currentlyFavorite = isFavorite;
                                  await favoriteCubit.toggleFavorite(
                                    hotelModel,
                                  );

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
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 20.h,
                      left: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 32,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "${hotelModel.rating}",
                              style: textStyle16BoldWhite.copyWith(
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 13.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          "${hotelModel.name}",
                          style: textStyle22RegularWhite.copyWith(
                            color: AppColors.black4,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.w),
                      child: Divider(
                        height: 2,
                        color: AppColors.black.withOpacity(0.1),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/send.svg",
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(width: 8.w),
                        Text("إحجز الآن", style: textStyle1Regularprimary),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
