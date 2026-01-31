import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/colors.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int rating = 4;

  final List<String> emojis = ['😍', '😄', '😐', '😟', '😢'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,

        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 120.h),
                  Text(
                    "شكراً لتقييمك!",
                    style: textStyle23Regularprimary.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "سنعمل بجهد أكبر لرضاك أكثر دوماً",
                    textAlign: TextAlign.center,
                    style: textStyle1Regularprimary.copyWith(
                      color: AppColors.primary.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () => setState(() => rating = index + 0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: SvgPicture.asset(
                            index < rating
                                ? "assets/icons/rating/🦆 emoji _white medium star_.svg"
                                : "assets/icons/rating/star-fill.svg",
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 32.h),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      fixedSize: Size(250.w, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      "إرسال التقييم",
                      style: textStyle25RegularWhite,
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
              child: Image.asset("assets/images/wave.png"),
            ),
            Positioned(
              top: 35.h,
              right: 0.w,
              left: 0.w,
              child: Center(
                child: Text(
                  emojis[(rating - 0).clamp(0, 4)],
                  style: const TextStyle(fontSize: 65),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}