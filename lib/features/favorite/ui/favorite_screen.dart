import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubit/favorite_cubit.dart';
import '../logic/cubit/favorite_state.dart';
import 'widget/custom_item_favorite.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteError) {
            return Center(child: Text(state.message));
          }

          if (state is FavoriteUpdated) {
            final favoriteItems = state.favorites;

            return favoriteItems.isEmpty
                ? const Center(child: Text('لا يوجد عناصر في المفضلة'))
                : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return Customfavoriteitem(hotelModel: item);
              },
            );
          }

          return const Center(child: Text('لا يوجد عناصر في المفضلة'));
        },
      ),
    );
  }
}