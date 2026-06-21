import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import '../../../core/helpers/contact/build_error_widget.dart';
import '../../../core/helpers/contact/build_favorite_notfound.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../core/network/model/hotel_model.dart';
import '../logic/cubit/favorite_cubit.dart';
import '../logic/cubit/favorite_state.dart';
import '../../../core/helpers/widget/custom_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppbarWidget(name: 'المفضله', onTap: () {}),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteError) {
            return buildNoConnectionWidget(
              onRetry: () => context.read<FavoriteCubit>().loadFavorites(),
            );
          }

          final List<HotelModel> favorites =
              state is FavoriteUpdated ? state.favorites : [];

          if (favorites.isEmpty) {
            return buildFavoriteNotFoundWidget(
              onRetry: () => context.go(routes.homeScreen),
            );
          }

          return RefreshIndicator(
            onRefresh: () async =>
                context.read<FavoriteCubit>().loadFavorites(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: favorites.length,
              itemBuilder: (_, i) => CustomItem(
                key: ValueKey(favorites[i].id),
                hotelModel: favorites[i],
                isContinar: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
