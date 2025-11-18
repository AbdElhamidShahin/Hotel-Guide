// lib/features/favorite/ui/widget/custom_item_favorite.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snackly/snackly.dart';

import '../../../../core/network/hotel_model.dart';
import '../../../home/ui/custom_details_screen.dart';
import '../../logic/cubit/favorite_cubit.dart';
import '../../logic/cubit/favorite_state.dart';

class Customfavoriteitem extends StatelessWidget {
  final HotelModel hotelModel;

  const Customfavoriteitem({super.key, required this.hotelModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomDetailsScreen(hotelModel: hotelModel),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // زر الحذف من المفضلة
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                    onPressed: () {
                      context.read<FavoriteCubit>().toggleFavorite(hotelModel);

                      Snackly.success(
                        context: context,
                        title: "تم الحذف من المفضلة",
                        style: SnackbarStyle.filled,
                      );
                    },
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            hotelModel.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            hotelModel.description.length > 30
                                ? hotelModel.description.substring(0, 30)
                                : hotelModel.description,
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      hotelModel.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey[200],
                        child: Image.asset(
                          'assets/Image/logo.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
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