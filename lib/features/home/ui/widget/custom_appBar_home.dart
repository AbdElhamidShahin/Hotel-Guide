import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class CustomAppbarHome extends StatelessWidget {
  const CustomAppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Image.asset(
            "assets/icons/search.png",
            height: 40,
            width: 40,
            color: Color(0xFF222222),
          ),
          Spacer(),
          Image.asset("assets/images/logo/logo.png", height: 83, width: 66),
        ],
      ),
    );
  }
}
