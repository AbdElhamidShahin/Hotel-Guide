import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme_data.dart';
import '../../../core/theme/colors.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';

/// "الشروط والأحكام" — same visual language as PrivacyPolicyScreen
/// (hero header + numbered section cards).
class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppbarWidget(
        name: 'الشروط والأحكام',
        onTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const _TermsHero(),
            SizedBox(height: 28.h),
            _SectionCard(
              number: '01',
              title: 'قبول الشروط',
              icon: Icons.task_alt_rounded,
              content:
                  'باستخدامك لتطبيق أكوا بوكينج فإنك توافق على جميع الشروط والأحكام '
                  'الواردة في هذه الصفحة. إذا كنت لا توافق على أي بند منها، '
                  'يرجى التوقف عن استخدام التطبيق.',
            ),
            SizedBox(height: 16.h),
            _SectionCard(
              number: '02',
              title: 'الحجوزات والدفع',
              icon: Icons.calendar_month_rounded,
              bullets: const [
                'يلتزم المستخدم بإدخال بيانات صحيحة عند إتمام عملية الحجز.',
                'تتم عمليات الدفع عبر بوابات دفع آمنة ومعتمدة.',
                'تأكيد الحجز يصدر فقط بعد نجاح عملية الدفع بالكامل.',
                'الأسعار المعروضة قابلة للتغيير دون إشعار مسبق حتى تأكيد الحجز.',
              ],
            ),
            SizedBox(height: 16.h),
            _SectionCard(
              number: '03',
              title: 'الإلغاء والاسترداد',
              icon: Icons.event_busy_rounded,
              content:
                  'تخضع عمليات الإلغاء واسترداد المبالغ لسياسة الإلغاء الخاصة '
                  'بكل فندق، والموضحة بالتفصيل في صفحة سياسة الإلغاء داخل التطبيق. '
                  'يُنصح بمراجعتها قبل إتمام الحجز.',
            ),
            SizedBox(height: 16.h),
            _SectionCard(
              number: '04',
              title: 'مسؤوليات المستخدم',
              icon: Icons.gpp_good_rounded,
              bullets: const [
                'الحفاظ على سرية بيانات حسابك وعدم مشاركتها مع الغير.',
                'عدم استخدام التطبيق لأي غرض غير قانوني أو مخالف للأنظمة.',
                'تحمل مسؤولية أي بيانات غير صحيحة يتم إدخالها عند الحجز.',
              ],
            ),
            SizedBox(height: 16.h),
            _SectionCard(
              number: '05',
              title: 'حدود المسؤولية',
              icon: Icons.balance_rounded,
              content:
                  'يعمل أكوا بوكينج كوسيط بين المستخدم والفنادق المعروضة على المنصة، '
                  'ولا يتحمل مسؤولية مباشرة عن جودة الخدمة المقدمة من الفندق نفسه. '
                  'نسعى دائمًا للتحقق من دقة المعلومات المعروضة، لكننا لا نضمن '
                  'خلوها التام من الأخطاء.',
            ),
            SizedBox(height: 16.h),
            _SectionCard(
              number: '06',
              title: 'التعديلات على الشروط',
              icon: Icons.update_rounded,
              content:
                  'نحتفظ بالحق في تعديل هذه الشروط والأحكام في أي وقت. '
                  'يُعد استمرارك في استخدام التطبيق بعد نشر أي تعديل بمثابة '
                  'موافقة ضمنية على الشروط المُحدّثة.',
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

// ── Hero header ──────────────────────────────────────────────────────────────

class _TermsHero extends StatelessWidget {
  const _TermsHero();

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
                'الشروط والأحكام',
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
                  Icons.description_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'يرجى قراءة هذه الشروط بعناية قبل استخدام تطبيق أكوا بوكينج، '
            'فهي تنظم العلاقة بينك وبين المنصة.',
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

// ── Section card ──────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String number;
  final String title;
  final IconData icon;
  final String? content;
  final List<String>? bullets;

  const _SectionCard({
    required this.number,
    required this.title,
    required this.icon,
    this.content,
    this.bullets,
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
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.font18BoldGray(context).copyWith(
                    fontSize: 17.sp,
                  ),
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
              SizedBox(width: 8.w),
              Text(
                number,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary.withOpacity(0.18),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(height: 1, color: cs.outline),
          SizedBox(height: 14.h),
          if (content != null)
            Text(
              content!,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppTextStyles.font14RegularNightfall(context).copyWith(
                height: 1.85,
              ),
            ),
          if (bullets != null)
            ...bullets!.map(
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
                        style:
                            AppTextStyles.font14RegularNightfall(context)
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
