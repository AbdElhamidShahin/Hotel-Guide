import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/app_theme_data.dart';
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
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final mainColor = isDark ? Colors.white : cs.primary;

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
                color: cs.surface,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 120.h),

                  /// Title
                  Text(
                    'شكراً لتقييمك!',
                    style: AppTextStyles.font23RegularPrimary(
                      context,
                    ).copyWith(color: mainColor),
                  ),

                  SizedBox(height: 16.h),

                  /// Subtitle
                  Text(
                    'سنعمل بجهد أكبر لرضاك أكثر دوماً',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font17RegularPrimary(
                      context,
                    ).copyWith(color: mainColor.withOpacity(0.6)),
                  ),

                  SizedBox(height: 32.h),

                  /// Stars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () => setState(() => rating = index + 1),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: SvgPicture.asset(
                            index < rating
                                ? 'assets/icons/rating/🦆 emoji _white medium star_.svg'
                                : 'assets/icons/rating/star-fill.svg',
                            width: 32.r,
                            height: 32.r,
                            colorFilter: index < rating
                                ? null
                                : ColorFilter.mode(
                                    mainColor.withOpacity(0.4),
                                    BlendMode.srcIn,
                                  ),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 35.r),

                  /// Button
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      fixedSize: Size(250.w, 60.h),
                    ),
                    child: Text(
                      'إرسال التقييم',
                      style: AppTextStyles.font25RegularWhite(
                        context,
                      ).copyWith(color: isDark ? Colors.black : Colors.white),
                    ),
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),

            /// Wave image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
              child: Image.asset('assets/images/wave.png'),
            ),

            /// Emoji
            Positioned(
              top: 35.h,
              right: 0,
              left: 0,
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
