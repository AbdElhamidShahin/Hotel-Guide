import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/routers.dart';
import '../../../core/theme/app_theme_data.dart';
import '../../../core/theme/colors.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Inherits scaffoldBackgroundColor from AppThemeData automatically.
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
              // Migrated from frozen font28BoldBlack global.
              Text(
                'تحقق من بريدك الإلكتروني',
                style: AppTextStyles.font28BoldBlack(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              // Migrated from frozen font16RegularMuted global.
              Text(
                'تم إرسال رابط التفعيل إلى:\n$email\nيرجى التحقق من صندوق الوارد.',
                style: AppTextStyles.font16RegularMuted(context),
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
                  // Migrated from frozen font16BoldWhite global.
                  // Always white — on primary-coloured button.
                  child: Text(
                    'الذهاب لتسجيل الدخول',
                    style: AppTextStyles.font16BoldWhite(context),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () => context.pop(),
                // Migrated from frozen font17RegularPrimary global.
                child: Text(
                  'رجوع',
                  style: AppTextStyles.font17RegularPrimary(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
