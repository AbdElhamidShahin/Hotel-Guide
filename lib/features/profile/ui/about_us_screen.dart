import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FC),
      appBar: CustomAppbarWidget(
        name: 'من نحن',
        onTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ── Hero intro ─────────────────────────────────────────────
            _HeroIntro(),
            SizedBox(height: 28.h),

            // ── Sections ───────────────────────────────────────────────
            _SectionCard(
              title: 'من نحن',
              icon: Icons.info_outline_rounded,
              content:
              'مرحبًا بك في منصة فندقي، الوجهة التي ضممت لتكون حلقة الوصل بين الزائر والفندق، '
                  'ولتمنحك تجربة مختلفة تمامًا في عالم استكشاف أماكن الإقامة داخل مصر.\n\n'
                  'نحن نؤمن أن رحلة البحث عن فندق لا يجب أن تكون فوضوية أو معقدة، لذلك أنشأنا '
                  'هذه المنصة لنقدم لك المعلومات التي تحتاجها بوضوح، وبأقل عدد ممكن من الخطوات.\n\n'
                  'منصة تجمع بين البساطة والقوة — فمنا لتطوير واجهة سهلة الاستخدام، '
                  'وتجربة تُصفِّح مريحة تساعدك على الوصول إلى الفندق المناسب خلال ثوانٍ.\n\n'
                  'هدفنا ليس مجرد عرض قائمة فنادق، بل تقديم محتوى دقيق ومتكامل يساعدك على '
                  'اتخاذ القرار بثقة، من صور وخدمات وموقع وطرق التواصل.\n\n'
                  'رؤيتنا أن نصبح الدليل الأول للمسافرين داخل مصر، والمرجع الأساسي لكل من يبحث '
                  'عن فندق يناسب رحلته.',
            ),

            SizedBox(height: 16.h),

            _SectionCard(
              title: 'رسالتنا',
              icon: Icons.campaign_outlined,
              bullets: const [
                'نحن هنا لنبسط التجربة.',
                'لجعل عملية البحث عن فندق سهلة، سريعة، وواضحة.',
                'ولنربط بين الفنادق والعملاء بحديثة تلائم العالم الرقمي الحالي.',
              ],
            ),

            SizedBox(height: 16.h),

            _SectionCard(
              title: 'قيمنا',
              icon: Icons.verified_outlined,
              bullets: const [
                'الشفافية: نقدم معلومات حقيقية، واضحة، وموثوقة.',
                'السهولة: تصميم بسيط وتجربة سلسة تناسب كل الأعمار.',
                'الابتكار: نطوّر المنصة باستمرار لإضافة أدوات جديدة تخدم المستخدم.',
                'الاحترافية: من طريقة عرض المحتوى وصولًا إلى تجربة التصفح.',
              ],
            ),

            SizedBox(height: 16.h),

            _SectionCard(
              title: 'مستقبل المنصة',
              icon: Icons.rocket_launch_outlined,
              content:
              'نحن نعمل على بناء علامة تجارية قوية في مجال الضيافة الرقمية.\n\n'
                  'ومع توسعنا، ستتحول المنصة من مجرد دليل للفنادق إلى مركز متكامل للحجوزات، '
                  'المراجعات، الخرائط التفاعلية، وإدارة الإقامات داخل مصر.\n\n'
                  'في ستاي إيجيبت، رحلتك تبدأ من هنا.\n'
                  'ومن هنا ستصل إلى المكان الأنسب لك بكل سهولة.',
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

// ── Hero intro card ───────────────────────────────────────────────────────────

class _HeroIntro extends StatelessWidget {
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
                'منصة فندقي',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
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
                child: Icon(Icons.hotel_rounded, color: Colors.white, size: 24.sp),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'دليلك الأول للإقامة في مصر — نربط الزائر بالفندق المناسب '
                'بأقل جهد وأعلى ثقة.',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 13.5.sp,
              fontFamily: 'Cairo',
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
  final String title;
  final IconData icon;
  final String? content;
  final List<String>? bullets;

  const _SectionCard({
    required this.title,
    required this.icon,
    this.content,
    this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1F3C),
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
          Container(height: 1, color: const Color(0xFFEEEEF5)),
          SizedBox(height: 14.h),

          // Content
          if (content != null)
            Text(
              content!,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13.5.sp,
                fontFamily: 'Cairo',
                color: const Color(0xFF555566),
                height: 1.85,
              ),
            ),

          // Bullets
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
                        style: TextStyle(
                          fontSize: 13.5.sp,
                          fontFamily: 'Cairo',
                          color: const Color(0xFF555566),
                          height: 1.75,
                        ),
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