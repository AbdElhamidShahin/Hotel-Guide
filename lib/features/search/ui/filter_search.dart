// features/search/ui/filter_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubit/search_cubit.dart';
import '../logic/cubit/search_state.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SearchCubit>();
    final filters = cubit.availableFilters;

    return Scaffold(
      appBar: AppBar(
        title: Text("الفلاتر"),
        actions: [
          TextButton(
            onPressed: () {
              cubit.clearFilters();
              Navigator.pop(context);
            },
            child: Text("مسح الكل", style: TextStyle(color: Colors.red)),
          )
        ],
      ),

      body: cubit.state is SearchLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        padding: EdgeInsets.all(16),
        children: filters.entries.map((entry) {
          final key = entry.key;       // مثل city / view / services
          final values = entry.value;  // قائمة الاختيارات

          // اختار نوع الويجت حسب نوع القيمة
          if (values.isEmpty) return SizedBox();

          // لو قائمة نصوص عادية مثل city/view → Dropdown
          if (key != "services" && key != "rating") {
            return _buildDropDown(
              title: key,
              values: values,
              cubit: cubit,
            );
          }

          // لو قائمة services → Chips متعددة
          if (key == "services") {
            return _buildMultiChip(
              title: key,
              values: values,
              cubit: cubit,
            );
          }

          // لو rating → Chips اختيار واحد
          if (key == "rating") {
            return _buildSingleChip(
              title: key,
              values: values,
              cubit: cubit,
            );
          }

          return SizedBox();
        }).toList()
          ..add(
            ElevatedButton(
              onPressed: () {
                cubit.applyFilters();
                Navigator.pop(context);
              },
              child: Text("تطبيق الفلاتر"),
            ),
          ),
      ),
    );
  }

  Widget _buildDropDown({required String title, required List values, required SearchCubit cubit}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        DropdownButtonFormField(
          value: cubit.selectedFilters[title],
          items: [
            DropdownMenuItem(value: null, child: Text("الكل")),
            ...values.map((v) => DropdownMenuItem(value: v, child: Text(v.toString())))
          ],
          onChanged: (v) => cubit.updateFilter(title, v),
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSingleChip({required String title, required List values, required SearchCubit cubit}) {
    final selected = cubit.selectedFilters[title];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: values.map((v) {
            return FilterChip(
              label: Text(v.toString()),
              selected: selected == v,
              onSelected: (sel) => cubit.updateFilter(title, sel ? v : null),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildMultiChip({required String title, required List values, required SearchCubit cubit}) {
    final selected = List<String>.from(cubit.selectedFilters[title] ?? []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: values.map((v) {
            return FilterChip(
              label: Text(v.toString()),
              selected: selected.contains(v),
              onSelected: (sel) {
                if (sel) {
                  selected.add(v);
                } else {
                  selected.remove(v);
                }
                cubit.updateFilter(title, selected);
              },
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
