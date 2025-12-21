import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/home/ui/widget/details/rating_dialog.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCircularIcon("assets/icons/rating/Share_Icon_UIA.svg"),
            SizedBox(width: 16.w),
            _buildCircularIcon("assets/icons/rating/like.svg"),
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (context) => const RatingDialog(),
              ),
              child: _buildCircularIcon("assets/icons/rating/star.svg"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularIcon(String image) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: SvgPicture.asset(
        image,
        height: 24.h,
        width: 24.w,
        color: AppColors.primary,
      ),
    );
  }
}
