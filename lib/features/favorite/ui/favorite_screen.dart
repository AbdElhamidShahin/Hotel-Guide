import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; // لإمكانية العودة بالـ goRouter
import 'package:hotel_guide/core/router/routers.dart';

import '../../../core/helpers/contact/build_error_widget.dart';
import '../../../core/helpers/contact/build_favorite_notfound.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../core/network/hotel_model.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/colors.dart'; // نفترض وجود AppColors
import '../logic/cubit/favorite_cubit.dart';
import '../logic/cubit/favorite_state.dart';
import '../../../core/helpers/widget/custom_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(name: "المفضله"),

      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteError) {
            return buildNoConnectionWidget(
              onRetry: () {
                context.read<FavoriteCubit>().loadFavorites();
              },
            );
          }

          final List<HotelModel> favoriteItems = (state is FavoriteUpdated)
              ? state.favorites
              : [];
          if (favoriteItems.isEmpty) {
            return buildFavoriteNotFoundWidget(
              onRetry: () {
                context.go(routes.homeScreen);
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<FavoriteCubit>().loadFavorites();
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return CustomItem(
                  key: ValueKey(item.id),
                  hotelModel: item,
                  isContinar: true,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
