import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_cubit.dart';
import '../logic/cubit/search_state.dart';
import 'custom_search_list_view.dart';
import 'filter_search.dart'; // تأكد من مسار الملف الصحيح

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // هذا السطر كان يسبب الكراش إذا لم يكن البروفايدر موجوداً في الشجرة العليا
    // تأكد من أنك غلفت SearchView بـ BlocProvider كما شرحت في الخطوة 1
    context.read<SearchCubit>().fetchHotels();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CustomTextFeild(
                controller: _searchController,
                onChanged: (value) {
                  context.read<SearchCubit>().searchLocal(value);
                },
              ),
            ),

            // Filters Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Search Results", style: TextStyle(fontSize: 15, color: Colors.grey)), // تم تعديل الستايل ليعمل مباشرة

                  // زر الفلتر مع التصحيح المهم
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {
                      // التقاط الكيوبت الحالي لتمريره
                      final cubit = context.read<SearchCubit>();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubit, // تمرير القيمة (Pass by Reference)
                            child: FilterPage(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Results Header Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Search Results", style: TextStyle(fontSize: 15, color: Colors.grey)),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      // هنا نستخدم filteredCount التي قمت بتعريفها في الكيوبت لتكون أدق
                      final count = context.read<SearchCubit>().filteredCount;
                      if (state is SearchSuccess) {
                        return Text(
                          "$count hotels found",
                          style: TextStyle(color: Colors.grey[600]),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),

            // Hotels List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const CustomSearchListView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CustomTextField كما هو بدون تغيير
class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  const CustomTextFeild({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search for hotels...',
        prefixIcon: Icon(Icons.search),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            controller.clear();
            onChanged?.call('');
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}