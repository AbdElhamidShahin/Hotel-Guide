import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/colors.dart';

import '../../../../core/router/routers.dart';
import '../../../search/ui/search_screen.dart';

class CustomAppbarHome extends StatelessWidget {
  const CustomAppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
             onTap: () {
               context.go(routes.searchScreen);

             },
            child: Image.asset(
              "assets/icons/search.png",
              height: 40,
              width: 40,
              color: Color(0xFF222222),
            ),
          ),
          Spacer(),
          Image.asset("assets/images/logo/logo.png", height: 83, width: 66),
        ],
      ),
    );
  }
}
