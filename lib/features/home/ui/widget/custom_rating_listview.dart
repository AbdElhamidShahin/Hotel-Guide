import 'package:flutter/material.dart';

import 'custom_rating_listview_item.dart';

class CustomRatingListview extends StatelessWidget {
  const CustomRatingListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,

      itemBuilder: (context, index) {
        return CustomRatingListviewItem();
      },
    );
  }
}


