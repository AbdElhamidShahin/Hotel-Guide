import 'package:flutter/material.dart';
import '../../../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../../../core/helpers/widget/custom_item.dart';
import '../../../../../core/network/model/city_model.dart';
import '../../../../../core/network/model/hotel_model.dart';

class CityHotelsScreen extends StatelessWidget {
  final CityModel city;
  final List<HotelModel> hotels;

  const CityHotelsScreen({super.key, required this.city, required this.hotels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(name: city.name, onTap: () => Navigator.pop(context)),
      body: hotels.isEmpty
          ? const Center(child: Text("لا توجد فنادق في هذه المدينة"))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return CustomItem(hotelModel: hotel, isContinar: false);
        },
      ),
    );
  }
}
