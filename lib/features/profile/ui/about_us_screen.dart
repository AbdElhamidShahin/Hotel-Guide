import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarWidget(
        name: "من نحن",
        onTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ─── من نحن ───
            _SectionBlock(
              title: "من نحن",
              content:
              "منصة فندقي هي المنصة الأولى التي جمعت أكثر من ١٥٠٠ فندق وشقة فندقية ووحدة سكنية مُصنَّفة تحت نظام واحد، يتيح للمسافر مقارنة الأسعار والمرافق واختيار الأنسب له — سواء للسياحة أو العمل أو الإقامة والحجوزات.\n\nندعو تقديم منصة استثمارية وشراكة فعّالة مع المنشآت السياحية في الفصل التالي من نمو المقاطعة السياحية في مصر.\n\nهدفنا تحقيق مستوى جودة عالمية مبني في قطاع الضيافة مع تطوير حلول مبتكرة ومنظومة متكاملة للأعمال.\n\nمن أصل ١٦٠٠+ فندق مُصنَّف في مصر، تعامل معنا ٩٣٪ من القطاعين العام والخاص لتوفير تجربة سياحية متكاملة وخدمات احترافية لأكبر شركات السياحة والطيران.\n\nنؤمن أن تحقيق التميز في الضيافة يتطلب التفاصيل الدقيقة، لذلك نعمل مع المطورين والمستثمرين والقطاع الإلكتروني لتقديم خدمات متقدمة وفق المعايير الدولية.\n\nنسعى دائمًا لتطوير القطاع، من خلال ربط المنشآت بشبكة واسعة من الشركاء والقطاع الإلكتروني — للتأهيل نحو المستقبل وتحقيق أهدافنا.",
            ),

            SizedBox(height: 28.h),

            // ─── رسالتنا ───
            _SectionBlock(
              title: "رسالتنا",
              content: null,
              bullets: [
                "دعم هذا رؤية الدولة",
                "تحقيق متطلبات من خلال شبكة منظمة وفعّالة",
                "تربط المنشآت والمنافذ بالديناميكية بشبكة تشغيل الفندق الرقمي",
              ],
            ),

            SizedBox(height: 28.h),

            // ─── قيمنا ───
            _SectionBlock(
              title: "قيمنا",
              content: null,
              bullets: [
                "الشفافية: تقديم معلومات دقيقة وموثوقة",
                "الجودة: المنظومة تضم أفضل المنشآت المُصنَّفة في مصر",
                "الابتكار: تقديم الأنظمة لإطلاق تجربة جديدة خدمة للمستثمرين",
                "الاحترافية: تعامل بمنهجية عرض للمستوى الدولي أمام الاستثمار",
              ],
            ),

            SizedBox(height: 28.h),

            // ─── مستقبل المنصة ───
            _SectionBlock(
              title: "مستقبل المنصة",
              content:
              "نسعى للتطور نحو منصة رائدة على مستوى القارة الإفريقية.\n\nنحو توظيف خدمات محدودة من خلال تعاون فعّال مع نظام فندقي وتكنولوجي وخدمات المستقبلية في القارة الإفريقية داخل مصر.\n\nفي نماذج أجمعته يمكنك تقديمها أيضًا.\n\nنحو هذا الاتجاه في المكان الأنسب لكل مسؤولية.",
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// Section Block Widget
// ─────────────────────────────────────────
class _SectionBlock extends StatelessWidget {
  final String title;
  final String? content;
  final List<String>? bullets;

  const _SectionBlock({
    required this.title,
    this.content,
    this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Title with accent line
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1F3C),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 4.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),

        SizedBox(height: 10.h),

        // Divider
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 1,
            color: const Color(0xFFE8E8EE),
          ),
        ),

        SizedBox(height: 12.h),

        // Content
        if (content != null)
          Text(
            content!,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13.5.sp,
              color: const Color(0xFF444444),
              height: 1.8,
            ),
          ),

        // Bullets
        if (bullets != null)
          ...bullets!.map(
                (item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                        color: const Color(0xFF444444),
                        height: 1.7,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Container(
                      width: 6.w,
                      height: 6.w,
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
    );
  }
}