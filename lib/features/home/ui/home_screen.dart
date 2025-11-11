import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_appBar_home.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_rating_listview.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_welcome_header.dart';
import 'package:hotel_guide/features/home/ui/widget/top_rating_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbarHome(),
            SizedBox(height: 16),
            CustomWelcomeHeader(),
            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(
                height: 1,
                color: AppColors.black.withOpacity(0.1),
              ),
            ),
            SizedBox(height: 16),

            TopRatingWidget(),
            SizedBox(height: 24),
            SizedBox(height: 380, child: CustomRatingListview()),
            SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
