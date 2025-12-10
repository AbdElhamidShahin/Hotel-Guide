import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import 'package:snackly/snackly.dart';
import 'package:go_router/go_router.dart';

import '../../network/hotel_model.dart';
import '../../router/routers.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../../../features/favorite/logic/cubit/favorite_cubit.dart';
import '../../../features/favorite/logic/cubit/favorite_state.dart';

class CustomItem extends StatefulWidget {
  final HotelModel hotelModel;
  final  bool isContinar ;
  final int? cityId;

  CustomItem({super.key, required this.hotelModel, required this.isContinar,  this.cityId});

  @override
  State<CustomItem> createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  @override
  void initState() {
    super.initState();
    context.read<HotelsCubit>().fetchHotelsByCity(widget.cityId!);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        final favoriteCubit = context.read<FavoriteCubit>();
        final isCurrentlyFavorite = favoriteCubit.isFavorite(widget.hotelModel);
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
              context.go(routes.customDetailsScreen, extra: widget.hotelModel);
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12), // Radios 12
                    child: CachedNetworkImage(
                      imageUrl: widget.hotelModel.imageUrl,
                      width: 150, // العرض: 150
                      height: 108, // الطول: 108
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 150,
                        height: 108,
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(), // أو ممكن تحط لودينج أنيميشن بدل الـ CircularProgressIndicator
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 150,
                        height: 108,
                        color: Colors.grey[200],
                        child: Center(
                          child: Image.asset(
                            "assets/images/logo/logo.png",
                            width: 150,
                            height: 108,
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
                                widget.hotelModel.name,
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
                                  "${widget.hotelModel.rating}",
                                  style: textStyle12BoldBlack,
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "${widget.hotelModel.locationUrl}",
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
                              "EGP ${widget.hotelModel.price}/",
                              style: textStyle18BoldGray.copyWith(
                                fontSize: 16,
                                color: AppColors.gray3,
                              ),
                            ),


                            Spacer(),
                            widget.isContinar
                                ? Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withOpacity(0.05),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  isCurrentlyFavorite ? Icons.favorite_rounded : Icons.favorite_border,
                                  color: isCurrentlyFavorite ? Colors.redAccent : Colors.black,
                                  size: 24,
                                ),
                                onPressed: () async {
                                  final wasFavorite = isCurrentlyFavorite;
                                  await favoriteCubit.toggleFavorite(widget.hotelModel);
                                  Snackly.success(
                                    context: context,
                                    title: wasFavorite ? "تم الحذف من المفضلة" : "تم الإضافة إلى المفضلة",
                                    style: SnackbarStyle.filled,
                                  );
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            )
                                : SizedBox(),                          ],
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
