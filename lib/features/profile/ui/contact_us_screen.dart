import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_theme_data.dart';
import '../../../core/theme/colors.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';

/// "اتصل بنا" — contact channels screen, same visual language as
/// AboutUsScreen / PrivacyPolicyScreen (hero header + section cards).
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppbarWidget(
        name: 'اتصل بنا',
        onTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const _ContactHero(),
            SizedBox(height: 24.h),
            _ContactChannelCard(
              icon: Icons.call_rounded,
              title: 'اتصل بنا هاتفيًا',
              value: '+20 100 123 4567',
              onTap: () => launchUrl(Uri.parse('tel:+201001234567')),
            ),
            SizedBox(height: 14.h),
            _ContactChannelCard(
              icon: Icons.email_rounded,
              title: 'راسلنا عبر البريد الإلكتروني',
              value: 'support@aquabooking.com',
              onTap: () => launchUrl(Uri.parse('mailto:support@aquabooking.com')),
            ),
            SizedBox(height: 14.h),
            _ContactChannelCard(
              icon: Icons.chat_bubble_rounded,
              title: 'تواصل عبر واتساب',
              value: '+20 100 123 4567',
              onTap: () => launchUrl(Uri.parse('https://wa.me/201001234567')),
            ),
            SizedBox(height: 14.h),
            _ContactChannelCard(
              icon: Icons.location_on_rounded,
              title: 'مقرنا الرئيسي',
              value: 'القاهرة، جمهورية مصر العربية',
              onTap: null,
            ),
            SizedBox(height: 22.h),
            _SocialRow(),
            SizedBox(height: 24.h),
            _SectionCard(
              title: 'ساعات العمل',
              icon: Icons.schedule_rounded,
              bullets: const [
                'السبت – الخميس: 9 صباحًا حتى 10 مساءً.',
                'الجمعة: 1 ظهرًا حتى 10 مساءً.',
                'فريق الدعم داخل التطبيق متاح على مدار الساعة.',
              ],
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

// ── Hero header ──────────────────────────────────────────────────────────────

class _ContactHero extends StatelessWidget {
  const _ContactHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D2B3E), Color(0xFF4A4766)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D2B3E).withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'نحن في خدمتك',
                style: AppTextStyles.font22BoldPrimary(context).copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.support_agent_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'هل لديك سؤال أو استفسار؟ فريق الدعم لدينا جاهز لمساعدتك '
            'في أي وقت عبر القنوات التالية.',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.font14RegularNightfall(context).copyWith(
              color: Colors.white.withOpacity(0.85),
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Contact channel card ─────────────────────────────────────────────────────

class _ContactChannelCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ContactChannelCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: isLight
                    ? Colors.black.withOpacity(0.05)
                    : Colors.transparent,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
            border: isLight ? null : Border.all(color: cs.outline, width: 0.5),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.font18BoldGray(context).copyWith(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      value,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.ltr,
                      style: AppTextStyles.font14RegularNightfall(context),
                    ),
                  ],
                ),
              ),
              if (onTap != null) ...[
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16.sp,
                  color: cs.surfaceTint,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Social links row ──────────────────────────────────────────────────────────

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.facebook_rounded, 'https://facebook.com'),
      (Icons.camera_alt_rounded, 'https://instagram.com'),
      (Icons.alternate_email_rounded, 'https://twitter.com'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => launchUrl(Uri.parse(item.$2)),
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.$1,
                    color: AppColors.primary,
                    size: 22.sp,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

// ── Section card (bullets) ───────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> bullets;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: isLight
                ? Colors.black.withOpacity(0.05)
                : Colors.transparent,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: isLight ? null : Border.all(color: cs.outline, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: AppTextStyles.font18BoldGray(context).copyWith(
                  fontSize: 17.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.all(7.r),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 18.sp),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(height: 1, color: cs.outline),
          SizedBox(height: 14.h),
          ...bullets.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: Text(
                      item,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.font14RegularNightfall(context)
                          .copyWith(height: 1.75),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Padding(
                    padding: EdgeInsets.only(top: 7.h),
                    child: Container(
                      width: 7.r,
                      height: 7.r,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
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
