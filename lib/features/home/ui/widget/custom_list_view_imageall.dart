import 'package:flutter/material.dart';
import 'package:hotel_guide/core/network/hotel_model.dart';

class CustomListViewImageAll extends StatelessWidget {
  const CustomListViewImageAll({super.key, required this.hotelModel});

  final HotelModel hotelModel;

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = hotelModel.imageUrlAll
        .split(';')
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty && url.startsWith('http'))
        .toList();

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = imageUrls[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 200,
                height: 160,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 200,
                    height: 160,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    hotelModel.imageUrl,
                    width: 200,
                    height: 160,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
