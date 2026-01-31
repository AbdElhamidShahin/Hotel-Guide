// // lib/features/search/ui/filter_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../logic/cubit/search_cubit.dart';
// import '../logic/cubit/search_state.dart';
//
// class FilterPage extends StatelessWidget {
//   const FilterPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<SearchCubit>();
//     final filters = cubit.availableFilters;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("الفلاتر"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               cubit.clearFilters();
//               Navigator.pop(context);
//             },
//
//
//             child: const Text("مسح الكل", style: TextStyle(color: Colors.red)),
//           )
//         ],
//       ),
//       body: cubit.state is SearchLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // Cities dropdown
//           if ((filters['cities'] ?? []).isNotEmpty) _buildDropDown(title: "cities", values: filters['cities']!, cubit: cubit),
//           // View dropdown
//           if ((filters['view'] ?? []).isNotEmpty) _buildDropDown(title: "view", values: filters['view']!, cubit: cubit),
//           // Breakfast dropdown
//           if ((filters['breakfast'] ?? []).isNotEmpty) _buildDropDown(title: "breakfast", values: filters['breakfast']!, cubit: cubit),
//           // Rating chips
//           if ((filters['rating'] ?? []).isNotEmpty) _buildSingleChip(title: "rating", values: filters['rating']!, cubit: cubit),
//
//           const SizedBox(height: 12),
//           ElevatedButton(
//             onPressed: () {
//               cubit.applyFilters();
//               Navigator.pop(context);
//             },
//             child: const Text("تطبيق الفلاتر"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDropDown({required String title, required List values, required SearchCubit cubit}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         DropdownButtonFormField(
//           value: cubit.selectedFilters[title],
//           items: [
//             const DropdownMenuItem(value: null, child: Text("الكل")),
//             ...values.map((v) => DropdownMenuItem(value: v, child: Text(v.toString())))
//           ],
//           onChanged: (v) => cubit.updateFilter(title, v),
//           decoration: const InputDecoration(border: OutlineInputBorder()),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
//
//   Widget _buildSingleChip({required String title, required List values, required SearchCubit cubit}) {
//     final selected = cubit.selectedFilters[title];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           children: values.map((v) {
//             return FilterChip(
//               label: Text(v.toString()),
//               selected: selected == v,
//               onSelected: (sel) => cubit.updateFilter(title, sel ? v : null),
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
