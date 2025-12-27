import 'package:flutter/material.dart';
import '../../../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../../../core/helpers/widget/custom_item.dart';
import '../../../../../core/network/city_model.dart';

class CityHotelsScreen extends StatelessWidget {
  final CityModel city;
  const CityHotelsScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(name: city.name),
      body: city.hotels.isEmpty
          ? const Center(child: Text("لا توجد فنادق في هذه المدينة"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: city.hotels.length,
              itemBuilder: (context, index) {
                final hotel = city.hotels[index];
                return CustomItem(hotelModel: hotel, isContinar: false);
              },
            ),
    );
  }
}
