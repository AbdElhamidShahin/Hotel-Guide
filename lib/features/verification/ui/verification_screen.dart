import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/routers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/colors.dart';

/// ✅ Fix: was an empty file — implemented the email verification screen.
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mark_email_unread_outlined,
                size: 90.sp,
                color: AppColors.primary,
              ),
              SizedBox(height: 32.h),
              Text(
                'تحقق من بريدك الإلكتروني',
                style: font28BoldBlack,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                'تم إرسال رابط التفعيل إلى:\n$email\nيرجى التحقق من صندوق الوارد.',
                style: font16RegularMuted,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () => context.go(routes.loginScreen),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    'الذهاب لتسجيل الدخول',
                    style: font16BoldWhite,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'رجوع',
                  style: font17RegularPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
