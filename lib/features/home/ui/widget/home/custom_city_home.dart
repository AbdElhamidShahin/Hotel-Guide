import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class CustomCityHome extends StatelessWidget {
  const CustomCityHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              CustomCityHomeItem(image: 'assets/images/city/alex.jpg', text: 'الإسكندرية',),
              SizedBox(width: 20),
              CustomCityHomeItem(image: 'assets/images/city/cairo.png', text: 'القاهرة',),
            ],
          ),
          SizedBox(height: 20),

          Row(
            children: [
              CustomCityHomeItem(image: 'assets/images/city/Hurghada.png', text: 'الغردقة',),
              SizedBox(width: 20),

              CustomCityHomeItem(image: 'assets/images/city/sharm.png', text: 'شرم الشيخ',),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomCityHomeItem extends StatelessWidget {
  const CustomCityHomeItem({
    super.key,
    required this.image,
    required this.text,
  });
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.black4.withOpacity(0.45), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // الصورة
            Image.asset(
              image,
              width: MediaQuery.of(context).size.width * 0.42,
              height: 140,
              fit: BoxFit.cover,
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.42,
              height: 140,
              color: Colors.black.withOpacity(0.3),
            ),

            Positioned(
              right: 0,
              left: 0,
              bottom: 10,
              child: Center(
                child: Text(
                  text,
                  style: textStyle23SemiBoldBlack.copyWith(
                    color: AppColors.white,
                    fontSize: 22
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
