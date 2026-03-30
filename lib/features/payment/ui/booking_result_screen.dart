import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/routers.dart';

class BookingResultScreen extends StatelessWidget {
  const BookingResultScreen({
    super.key,
    required this.isSuccess,
    this.paymentMethod,
    this.errorMessage,
  });

  final bool isSuccess;
  final String? paymentMethod;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final color = isSuccess ? const Color(0xFF22C55E) : const Color(0xFFEF4444);
    final bgColor = isSuccess
        ? const Color(0xFFF0FDF4)
        : const Color(0xFFFFF1F2);
    final cardAccent = isSuccess
        ? const Color(0xFFBBF7D0)
        : const Color(0xFFFECACA);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // ── Booking Card Illustration ──────────────
              _BookingCardIllustration(
                isSuccess: isSuccess,
                cardAccent: cardAccent,
                bgColor: bgColor,
                color: color,
              ),

              SizedBox(height: 40.h),

              // ── Title ──────────────────────────────────
              Text(
                isSuccess ? 'عملية حجز ناجحة' : 'فشلت عملية الحجز',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                  color: color,
                  fontFamily: 'Cairo',
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16.h),

              // ── Subtitle ───────────────────────────────
              Text(
                isSuccess
                    ? 'شكرًا لاستخدامك ${paymentMethod ?? 'AQUA'}'
                    : (errorMessage ?? 'تفقد رصيدك وحاول مرة أخرى'),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6B7280),
                  fontFamily: 'Cairo',
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              // ── Button ─────────────────────────────────
              _ResultButton(
                color: color,
                onTap: () => context.go(routes.homeScreen),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Booking Card Illustration ─────────────────────────────────────────────────

class _BookingCardIllustration extends StatelessWidget {
  const _BookingCardIllustration({
    required this.isSuccess,
    required this.cardAccent,
    required this.bgColor,
    required this.color,
  });

  final bool isSuccess;
  final Color cardAccent;
  final Color bgColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Outer card (background)
          Positioned(
            top: 0,
            left: 10.w,
            right: 10.w,
            child: Container(
              height: 230.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),

          // Inner card
          Positioned(
            top: 30.h,
            left: 30.w,
            right: 30.w,
            child: Container(
              height: 180.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header bar
                  Container(
                    height: 4.h,
                    margin: EdgeInsets.only(top: 12.h, left: 60.w, right: 60.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Status label
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: cardAccent,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bed_outlined, size: 16.r, color: color),
                        SizedBox(width: 6.w),
                        Text(
                          isSuccess ? 'تم الحجز' : 'فشل الحجز',
                          style: TextStyle(
                            color: color,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Content skeleton lines
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        // Square thumbnail
                        Container(
                          width: 44.r,
                          height: 44.r,
                          decoration: BoxDecoration(
                            color: cardAccent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Text lines
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 10.h,
                                decoration: BoxDecoration(
                                  color: cardAccent,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                height: 10.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: cardAccent,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Status Badge
          Positioned(
            bottom: 0,
            left: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circle icon
                Container(
                  width: 56.r,
                  height: 56.r,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.35),
                        blurRadius: 16,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    isSuccess ? Icons.check_rounded : Icons.close_rounded,
                    color: Colors.white,
                    size: 30.r,
                  ),
                ),
                SizedBox(width: 12.w),
                // Status lines
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 140.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 100.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Button ────────────────────────────────────────────────────────────────────

class _ResultButton extends StatelessWidget {
  const _ResultButton({required this.color, required this.onTap});

  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50.r),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'العودة للرئيسية',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ),
    );
  }
}
