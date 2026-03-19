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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 6)],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: Text(
                    faq.question,
                    textAlign: TextAlign.right,
                    style:  TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontFamily: 'Cairo',

                    ),
                  ),
                ),
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
                    child: const Icon(Icons.chevron_right_rounded,
                        color: Colors.white, size: 28),
                  ),
                ),  ],
            ),
            if (faq.isExpanded) ...[
              const SizedBox(height: 10),
              Text(
                faq.answer,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textGrey,
                  height: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}