import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/core/network/hotel_model.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_cubit.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_state.dart';
import '../../home/ui/widget/custom_rating_listview_item.dart';

class CustomSearchListView extends StatelessWidget {
  const CustomSearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          if (state.hotels.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hotel, size: 64, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    'No hotels found',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.hotels.length,
            itemBuilder: (context, index) {
              return CustomRatingListviewItem(hotelModel: state.hotels[index]);
            },
          );
        } else if (state is SearchFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  "Error: ${state.errorMessage}",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<SearchCubit>().fetchHotels(),
                  child: Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (state is SearchLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}