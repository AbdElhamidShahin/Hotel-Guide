import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snackly/snackly.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/hotel_model.dart';
import '../../../../core/router/routers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../logic/cubit/favorite_cubit.dart';
import '../../logic/cubit/favorite_state.dart';

class Customfavoriteitem extends StatelessWidget {
  final HotelModel hotelModel;

  const Customfavoriteitem({super.key, required this.hotelModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        final favoriteCubit = context.read<FavoriteCubit>();
        final isCurrentlyFavorite = favoriteCubit.isFavorite(hotelModel);
        return Container(
          height: 132,
          margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              context.go(routes.customDetailsScreen, extra: hotelModel);
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12), // Radios 12
                    child: Image.network(
                      hotelModel.imageUrl,
                      width: 150, // العرض: 150
                      height: 108, // الطول: 108
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 150,
                        height: 108,
                        color: Colors.grey[200],
                        child: Center(
                          child: Image.asset(
                            "assets/images/logo/logo.png",
                            width: 150, // العرض: 150
                            height: 108, // الطول: 108
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                hotelModel.name,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black6,
                                ),
                                textDirection: TextDirection.rtl,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 24,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${hotelModel.rating}",
                                  style: textStyle12BoldBlack,
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "${hotelModel.locationUrl}",
                          style: textStyle10BoldGray,
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Row(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [  Text(
                            "month",
                            style: textStyle18BoldGray.copyWith(
                              fontSize: 14,
                              color: AppColors.gray3.withOpacity(0.60),
                            ),
                          ),
                            Text(
                              "EGP ${hotelModel.price}/",
                              style: textStyle18BoldGray.copyWith(
                                fontSize: 16,
                                color: AppColors.gray3,
                              ),
                            ),


                            Spacer(),
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withOpacity(0.05),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                onPressed: () async {
                                  final wasFavorite = isCurrentlyFavorite;

                                  await favoriteCubit.toggleFavorite(hotelModel);


                                  Snackly.success(
                                    context: context,
                                    title: isCurrentlyFavorite
                                        ? "تم الحذف من المفضلة"
                                        : "تم الإضافة إلى المفضلة",
                                    style: SnackbarStyle.filled,
                                  );
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
