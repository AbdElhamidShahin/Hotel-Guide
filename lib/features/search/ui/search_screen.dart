import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_state.dart';
import 'package:hotel_guide/features/search/ui/widget/custom_appbar_search.dart';
import '../../../core/helpers/widget/custom_item.dart';
import '../../../core/network/connect/build_error_widget.dart';
import '../../../core/network/connect/build_not_found_search.dart';
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
                    return buildNoConnectionWidget(
                      onRetry: () {
                        context.read<SearchCubit>().loadHotels();
                      },
                    );
                  }
                  if (state is SearchSuccess) {
                    final hotels = state.hotels;

                    if (hotels.isEmpty) {
                      return Center(child: BuildNotFoundSearch());
                    }

                    return ListView.builder(
                      itemCount: hotels.length,
                      itemBuilder: (context, index) {
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
