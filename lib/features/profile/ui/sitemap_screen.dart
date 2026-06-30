import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routers.dart';
import '../../../core/theme/app_theme_data.dart';
import '../../../core/theme/colors.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';

/// "خريطة التطبيق" — mirrors the website's app-map / sitemap section.
/// Groups every reachable screen into sections, each tile routes
/// straight to the matching screen via go_router.
class SitemapScreen extends StatelessWidget {
  const SitemapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppbarWidget(
        name: 'خريطة التطبيق',
        onTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const _SitemapHero(),
            SizedBox(height: 28.h),

            _SitemapSection(
              title: 'الصفحات الرئيسية',
              subtitle: 'الوصول السريع إلى الأقسام الأساسية في المنصة',
              icon: Icons.language_rounded,
              tiles: [
                _SitemapTileData(
                  title: 'الرئيسية',
                  subtitle: 'نقطة الانطلاق لاكتشاف أفضل العروض والفنادق',
                  icon: Icons.home_rounded,
                  onTap: () => context.push(routes.homeScreen),
                ),
                _SitemapTileData(
                  title: 'اكتشف الفنادق',
                  subtitle: 'محرك بحث متقدم للفنادق والغرف المتاحة',
                  icon: Icons.explore_rounded,
                  onTap: () => context.push(routes.searchScreen),
                ),
                _SitemapTileData(
                  title: 'مساعد الحجز الذكي',
                  subtitle: 'تحدث مع الشات بوت لإيجاد الفندق المناسب',
                  icon: Icons.smart_toy_rounded,
                  onTap: () => context.push(routes.ChatScreen),
                ),
              ],
            ),
            SizedBox(height: 22.h),

            _SitemapSection(
              title: 'إدارة الحساب',
              subtitle: 'إدارة بياناتك الشخصية وحجوزاتك بكل سهولة',
              icon: Icons.person_rounded,
              tiles: [
                _SitemapTileData(
                  title: 'الملف الشخصي',
                  subtitle: 'تحديث بياناتك الشخصية وصورتك',
                  icon: Icons.account_circle_rounded,
                  onTap: () => context.push(routes.accountScreen),
                ),
                _SitemapTileData(
                  title: 'محفظتي',
                  subtitle: 'رصيد المحفظة والعمليات المالية',
                  icon: Icons.account_balance_wallet_rounded,
                  onTap: () => context.push(routes.walletScreen),
                ),
                _SitemapTileData(
                  title: 'المفضلة',
                  subtitle: 'الفنادق التي قمت بحفظها للرجوع إليها',
                  icon: Icons.favorite_rounded,
                  onTap: () => context.push(routes.favoritesScreen),
                ),
                _SitemapTileData(
                  title: 'الإشعارات',
                  subtitle: 'تنبيهاتك وآخر تحديثات حجوزاتك',
                  icon: Icons.notifications_rounded,
                  onTap: () => context.push(routes.notification),
                ),
              ],
            ),
            SizedBox(height: 22.h),

            _SitemapSection(
              title: 'الدعم والمساعدة',
              subtitle: 'نحن هنا لمساعدتك في أي وقت',
              icon: Icons.support_agent_rounded,
              tiles: [
                _SitemapTileData(
                  title: 'تواصل معنا',
                  subtitle: 'فريق الدعم جاهز للرد على استفساراتكم',
                  icon: Icons.headset_mic_rounded,
                  onTap: () => context.push(routes.ContactUsScreen),
                ),
                _SitemapTileData(
                  title: 'الأسئلة الشائعة',
                  subtitle: 'إجابات سريعة على التساؤلات الأكثر تكرارًا',
                  icon: Icons.help_rounded,
                  onTap: () => context.push(routes.FaqPage),
                ),
                _SitemapTileData(
                  title: 'من نحن',
                  subtitle: 'تعرف على رؤيتنا ورسالتنا وقيمنا',
                  icon: Icons.info_rounded,
                  onTap: () => context.push(routes.AboutUsScreen),
                ),
                _SitemapTileData(
                  title: 'سياسة الخصوصية',
                  subtitle: 'كيف نحافظ على خصوصية وأمان بياناتك',
                  icon: Icons.privacy_tip_rounded,
                  onTap: () => context.push(routes.PrivacyPolicyScreen),
                ),
                _SitemapTileData(
                  title: 'الشروط والأحكام',
                  subtitle: 'الشروط التي تحكم استخدامك للمنصة',
                  icon: Icons.description_rounded,
                  onTap: () => context.push(routes.TermsConditionsScreen),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

// ── Hero header ──────────────────────────────────────────────────────────────
// Same dark gradient pattern used across the app's info screens.

class _SitemapHero extends StatelessWidget {
  const _SitemapHero();

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
                'خريطة الموقع والشرح التفصيلي',
                textAlign: TextAlign.right,
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
                  Icons.map_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'تعرف على هيكلية تطبيق أكوا بوكينج وكيفية التنقل بين أقسامه '
            'المختلفة للاستفادة القصوى من خدماتنا السياحية.',
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

// ── Section header + tiles group ────────────────────────────────────────────

class _SitemapSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<_SitemapTileData> tiles;

  const _SitemapSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font18BoldGray(context),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.font14RegularNightfall(context),
                ),
              ],
            ),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 20.sp),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        ...tiles.map(
          (t) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _SitemapTile(data: t),
          ),
        ),
      ],
    );
  }
}

// ── Single sitemap tile ──────────────────────────────────────────────────────
// Matches the "card with icon, title, description, and back-arrow" pattern
// seen in the website's app-map cards.

class _SitemapTileData {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SitemapTileData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
}

class _SitemapTile extends StatelessWidget {
  final _SitemapTileData data;

  const _SitemapTile({required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: data.onTap,
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
                child: Icon(
                  data.icon,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.title,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.font18BoldGray(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      data.subtitle,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.font14RegularNightfall(context)
                          .copyWith(fontSize: 12.5.sp, height: 1.4),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16.sp,
                color: cs.surfaceTint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
