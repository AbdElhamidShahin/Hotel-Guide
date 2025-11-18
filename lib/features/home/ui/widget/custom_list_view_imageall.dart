import 'package:flutter/material.dart';
import 'package:hotel_guide/core/network/hotel_model.dart';

class CustomListViewImageAll extends StatelessWidget {
  const CustomListViewImageAll({super.key, required this.hotelModel});

  final HotelModel hotelModel;

  final List<String> defaultImages = const [
    'assets/images/Offers.jpg',
    'assets/images/Offers.jpg',
    'assets/images/Offers.jpg',
    'assets/images/Offers.jpg',

  ];

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = hotelModel.imageUrlAll
        .split(';')
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty && url.startsWith('http'))
        .toList();

    final List<String> finalImages =
    imageUrls.isNotEmpty ? imageUrls : defaultImages;

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: finalImages.length,
        itemBuilder: (context, index) {
          final imageUrl = finalImages[index];

          // نعرض صورة الشبكة لو موجودة، وإلا الصورة الافتراضية
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl.startsWith('http')
                  ? Image.network(
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
                  return Image.asset(
                    defaultImages[index % defaultImages.length],
                    width: 200,
                    height: 160,
                    fit: BoxFit.cover,
                  );
                },
              )
                  : Image.asset(
                imageUrl,
                width: 200,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
