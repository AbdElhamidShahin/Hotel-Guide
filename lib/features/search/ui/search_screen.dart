import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_state.dart';
import 'package:hotel_guide/features/search/ui/widget/custom_appbar_search.dart';
import 'package:hotel_guide/features/search/ui/widget/show_filter_search.dart';
import '../logic/cubit/search_cubit.dart';
import '../../../core/helpers/widget/custom_item.dart';
import '../../../core/helpers/contact/build_error_widget.dart';
import '../../../core/helpers/contact/build_not_found_search.dart';

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
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            List<String> cities = [];
            List<String> views = [];

            if (state is SearchSuccess) {
              cities = state.cities;
              views = state.views;
            }

            return Column(
              children: [
                CustomAppbarSearch(
                  onChanged: (value) =>
                      context.read<SearchCubit>().search(value),
                  onFilterTap: () {
                    showFilterSearch(context, cities: cities, views: views);
                  },
                ),
                const SizedBox(height: 24),
                Expanded(child: _buildBody(state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(SearchState state) {
    if (state is SearchLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is SearchFailure) {
      return buildNoConnectionWidget(
        onRetry: () => context.read<SearchCubit>().loadHotels(),
      );
    }

    if (state is SearchSuccess) {
      if (state.hotels.isEmpty) {
        return Center(child: BuildNotFoundSearch());
      }
      return ListView.builder(
        itemCount: state.hotels.length,
        itemBuilder: (context, index) =>
            CustomItem(hotelModel: state.hotels[index], isContinar: false),
      );
    }

    return const SizedBox.shrink();
  }
}
