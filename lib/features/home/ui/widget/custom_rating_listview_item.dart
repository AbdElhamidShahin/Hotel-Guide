import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/network/hotel_model.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:snackly/snackly.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/helpers/favorite_manger.dart';
import '../../../../core/network/city_model.dart';
import '../../../../core/router/routers.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../favorite/logic/cubit/favorite_cubit.dart';
import '../../../favorite/logic/cubit/favorite_state.dart';

class CustomRatingListviewItem extends StatelessWidget {
  const CustomRatingListviewItem({super.key, required this.hotelModel});
  final HotelModel hotelModel;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        context.go(routes.customDetailsScreen, extra: hotelModel);
      },
      child: SizedBox(
        width: 350,
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
                            hotelModel.imageUrl,
                            width: double.infinity,
                            height: 230,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 30,
                      right: 25,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
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
                      bottom: 30,
                      left: 25,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 24,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${hotelModel.rating}",
                              style: textStyle16mediumWhite.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${hotelModel.name}",
                        style: textStyle22RegularWhite.copyWith(
                          color: AppColors.black4,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF2F2F2),
                            ),
                            child: // 💡 يجب تحديد النوع: Consumer<ItemProvider>
                                // استخدام Cubit بدلاً من Consumer
                                BlocProvider(
                                  create: (context) => getIt<FavoriteCubit>(),

                                  child: BlocBuilder<FavoriteCubit, FavoriteState>(
                                    builder: (context, state) {
                                      final isFavorite = context
                                          .read<FavoriteCubit>()
                                          .isFavorite(hotelModel);
                                  
                                      return IconButton(
                                        icon: Icon(
                                          isFavorite
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border,
                                          color: isFavorite
                                              ? Colors.redAccent
                                              : Colors.black,
                                          size: 32,
                                        ),
                                        onPressed: () {
                                          final bool currentlyFavorite =
                                              isFavorite;
                                          context
                                              .read<FavoriteCubit>()
                                              .toggleFavorite(hotelModel);
                                  
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$${hotelModel.price}",

                                style: textStyle28MediumBlack,
                              ),
                            ],
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
      ),
    );
  }
}
