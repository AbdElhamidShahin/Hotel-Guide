import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';
import '../../data/model/faq_model.dart';

class FaqItemTile extends StatelessWidget {
  final FaqModel faq;
  final VoidCallback onTap;

  const FaqItemTile({super.key, required this.faq, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // surface = white in light, dark card in dark mode.
          color: cs.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              // Shadow visible in light only; border handles dark depth.
              color: isLight
                  ? Colors.black.withOpacity(0.04)
                  : Colors.transparent,
              blurRadius: 6,
            ),
          ],
          border: isLight
              ? null
              : Border.all(color: cs.outline, width: 0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedRotation(
                  turns: faq.isExpanded ? -0.25 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    width: 34.w,
                    height: 34.h,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    // Always white — on primary circle, same in both themes.
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    faq.question,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      // onSurface = primary text, adapts in dark mode.
                      color: cs.onSurface,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
            if (faq.isExpanded) ...[
              const SizedBox(height: 10),
              Text(
                faq.answer,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  // onSurfaceVariant = secondary text, adapts in dark mode.
                  color: cs.onSurfaceVariant,
                  height: 1.6,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
