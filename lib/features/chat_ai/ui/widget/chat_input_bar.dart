import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final cs      = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 60.h),
      // surface = white in light, dark card in dark mode.
      color: cs.surface,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextField(
            controller: controller,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            // Input text colour from live theme.
            style: TextStyle(color: cs.onSurface, fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: 'ما نوع الفندق الذي تبحث عنه؟ دعني أساعدك',
              hintStyle: TextStyle(
                // surfaceTint = textMuted slot — adapts in dark mode.
                color: cs.surfaceTint,
                fontSize: 14.sp,
              ),
              hintTextDirection: TextDirection.rtl,
              filled: true,
              // surface = keeps fill consistent with the container.
              fillColor: cs.surface,
              contentPadding: EdgeInsets.fromLTRB(60.w, 12.h, 20.w, 12.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                // outline = themed border — correct shade in both modes.
                borderSide: BorderSide(color: cs.outline, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(color: cs.outline, width: 1),
              ),
            ),
          ),
          Positioned(
            left: -2,
            child: GestureDetector(
              onTap: isLoading ? null : onSend,
              child: Container(
                margin: EdgeInsets.all(4.w),
                height: 48.h,
                width: 48.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // Always primary — brand send button, same in both themes.
                  color: AppColors.primary,
                ),
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            // Always white — on primary circle.
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : SvgPicture.asset(
                          'assets/icons/send.svg',
                          height: 24.h,
                          width: 24.w,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
