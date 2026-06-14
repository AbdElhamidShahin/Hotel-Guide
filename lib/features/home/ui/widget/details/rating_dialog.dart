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

    return Dialog(
      // backgroundColor from dialogTheme in AppThemeData — adapts automatically.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                // surface = white in light, dark card in dark mode.
                color: cs.surface,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 120.h),
                  Text(
                    'شكراً لتقييمك!',
                    // Migrated from frozen font23RegularPrimary.
                    style: AppTextStyles.font23RegularPrimary(context).copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'سنعمل بجهد أكبر لرضاك أكثر دوماً',
                    textAlign: TextAlign.center,
                    // Migrated from frozen font17RegularPrimary.
                    style: AppTextStyles.font17RegularPrimary(context).copyWith(
                      color: AppColors.primary.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // التعديل داخل بناء النجوم التكراري:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () => setState(() => rating = index + 1), // تعديل بسيط للحساب الرياضي لتبدأ من 1 لـ 5
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: SvgPicture.asset(
                            index < rating
                                ? 'assets/icons/rating/🦆 emoji _white medium star_.svg'
                                : 'assets/icons/rating/star-fill.svg',
                            width: 32.r,
                            height: 32.r,
                            // التعديل: إضافة فتلر تلوين للنجمة غير النشطة لتظهر بوضوح في الـ Dark Mode
                            colorFilter: index < rating
                                ? null
                                : ColorFilter.mode(cs.outlineVariant, BlendMode.srcIn),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 35.r),
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
                      'إرسال التقييم',
                      // Migrated from frozen font25RegularWhite.
                      style: AppTextStyles.font25RegularWhite(context),
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
              child: Image.asset('assets/images/wave.png'),
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
