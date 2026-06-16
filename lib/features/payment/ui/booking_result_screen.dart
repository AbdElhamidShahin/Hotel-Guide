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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // إعداد ألوان متناسقة وحيوية حسب حالة الحجز وثيم التطبيق
    final color = isSuccess ? const Color(0xFF14AE5C) : const Color(0xFFFF3838);
    final bgColor = isSuccess
        ? (isDark ? const Color(0xFF0F291B) : const Color(0xFFF0FDF4))
        : (isDark ? const Color(0xFF2D1414) : const Color(0xFFFFF1F2));
    final cardAccent = isSuccess
        ? (isDark ? const Color(0xFF1B4D3E) : const Color(0xFFBBF7D0))
        : (isDark ? const Color(0xFF5C2424) : const Color(0xFFFECACA));

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              _BookingCardIllustration(
                isSuccess: isSuccess,
                cardAccent: cardAccent,
                bgColor: bgColor,
                color: color,
                isDark: isDark,
              ),
              SizedBox(height: 40.h),
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
              Text(
                isSuccess
                    ? 'شكرًا لاستخدامك ${paymentMethod ?? 'AQUA'}'
                    : (errorMessage ?? 'حدث خطأ ما، حاول مرة أخرى'),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontFamily: 'Cairo',
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 1),
              _ResultButton(
                color: color,
                onTap: () => context.go(routes.homeScreen),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookingCardIllustration extends StatelessWidget {
  const _BookingCardIllustration({
    required this.isSuccess,
    required this.cardAccent,
    required this.bgColor,
    required this.color,
    required this.isDark,
  });

  final bool isSuccess;
  final Color cardAccent;
  final Color bgColor;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final outerCardColor = isDark ? const Color(0xFF1E1E2C) : const Color(0xFFF3F4F6);
    final innerCardColor = isDark ? const Color(0xFF252535) : Colors.white;
    final badgeBgColor   = isDark ? const Color(0xFF1A1A2E) : const Color(0xFFFEFEFE);

    return SizedBox(
      height: 280.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // البطاقة الخلفية الخارجية
          Positioned(
            top: 0,
            left: 24.w,
            right: 24.w,
            child: Container(
              height: 225.h,
              decoration: BoxDecoration(
                color: outerCardColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),

          // البطاقة الأمامية الداخلية
          Positioned(
            top: 35.h,
            left: 45.w,
            right: 45.w,
            child: Container(
              height: 190.h,
              decoration: BoxDecoration(
                color: innerCardColor,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 5.h,
                    margin: EdgeInsets.only(top: 12.h, left: 80.w, right: 80.w),
                    decoration: BoxDecoration(
                      color: cardAccent,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bed_outlined, size: 18.r, color: const Color(0xFF9CA4AB)),
                        SizedBox(width: 6.w),
                        Text(
                          isSuccess ? 'تم الحجز مسبقاً' : 'الحجز ملغي',
                          style: TextStyle(
                            color: const Color(0xFF9CA4AB),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      children: [
                        Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: BoxDecoration(
                            color: cardAccent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 12.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  color: cardAccent,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                height: 8.h,
                                width: 50.w,
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

          // شارة الحالة (Status Badge) المتوضعة في الزاوية السفليّة
          Positioned(
            bottom: 0,
            left: 10.w,
            right: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: badgeBgColor,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF121933).withOpacity(isDark ? 0.3 : 0.08),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 8),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(18.r)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.35),
                          blurRadius: 12,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      isSuccess ? Icons.check_rounded : Icons.close_rounded,
                      color: Colors.white,
                      size: 26.r,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 120.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          width: 80.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultButton extends StatelessWidget {
  const _ResultButton({required this.color, required this.onTap});

  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220.w,
        height: 54.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50.r),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child:  Center(
          child: Text(
            'العودة للرئيسية',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ),
    );
  }
}