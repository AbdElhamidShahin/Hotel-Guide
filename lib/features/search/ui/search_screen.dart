import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_state.dart';
import 'package:hotel_guide/features/search/ui/widget/custom_appbar_search.dart';

import '../../../core/helpers/widget/custom_item.dart';
import '../logic/cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().loadHotels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbarSearch(
              onChanged: (value) {
                context.read<SearchCubit>().search(value);
              },
            ),
            SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SearchFailure) {
                    return Center(child: Text(state.message));
                  }

                  if (state is SearchSuccess) {
                    final hotels = state.hotels;

                    if (hotels.isEmpty) {
                      return const Center(child: Text("No hotels found"));
                    }

                    return ListView.builder(
                      itemCount: hotels.length,
                      itemBuilder: (context, index) {
                        final hotel = hotels[index];
                        return CustomItem(
                          hotelModel: state.hotels[index],
                          isContinar: false,
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
