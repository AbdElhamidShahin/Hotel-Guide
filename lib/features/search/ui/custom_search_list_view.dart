// // lib/features/search/ui/custom_search_list_view.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../logic/cubit/search_cubit.dart';
// import '../logic/cubit/search_state.dart';
// import '../../../widgets/custom_rating_listview_item.dart';
//
// class CustomSearchListView extends StatelessWidget {
//   const CustomSearchListView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SearchCubit, SearchState>(
//       builder: (context, state) {
//         if (state is SearchSuccess) {
//           if (state.hotels.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.hotel, size: 64, color: Colors.grey[400]),
//                   const SizedBox(height: 16),
//                   Text(
//                     'No hotels found',
//                     style: TextStyle(fontSize: 18, color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           return ListView.builder(
//             padding: EdgeInsets.zero,
//             itemCount: state.hotels.length,
//             itemBuilder: (context, index) {
//               final item = state.hotels[index];
//               return CustomRatingListviewItem(hotelData: item);
//             },
//           );
//         } else if (state is SearchFailure) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.error, size: 64, color: Colors.red),
//                 const SizedBox(height: 16),
//                 Text(
//                   "Error: ${state.errorMessage}",
//                   style: const TextStyle(fontSize: 16, color: Colors.red),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () => context.read<SearchCubit>().fetchHotels(),
//                   child: const Text('Try Again'),
//                 ),
//               ],
//             ),
//           );
//         } else if (state is SearchLoading || state is SearchInitial) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           return const SizedBox();
//         }
//       },
//     );
//   }
// }
