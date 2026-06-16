import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme_data.dart';
import '../../../core/theme/colors.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppbarWidget(
        name: 'سياسة الخصوصية',
        onTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _IntroCard(),
            SizedBox(height: 20.h),
            _NumberedSection(number: '١', title: 'المعلومات التي نقوم بجمعها',
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                _SubTitle('أولاً: المعلومات التي يقدمها المستخدم بنفسه'),
                SizedBox(height: 6.h),
                _BulletList(items: const ['الاسم','البريد الإلكتروني','رقم الهاتف','صورة الملف الشخصي (إن وُجد)','وكل ما لا نطلب أي معلومات خارج مصادر الأعمال']),
                SizedBox(height: 12.h),
                _SubTitle('ثانياً: المعلومات التي يتم جمعها تلقائياً'),
                SizedBox(height: 6.h),
                _BulletList(items: const ['نوع الجهاز والمتصفح','عنوان IP','الصفحات التي تم زيارتها على الموقع','مدة بقائك داخل المنصة','ملفات تعريف الارتباط (Cookies للتحسين الذاتي)']),
              ]),
            ),
            SizedBox(height: 16.h),
            _NumberedSection(number: '٢', title: 'استخدام المعلومات',
              child: _BulletList(items: const ['تحسين تجربة الحجز وتطوير المنصة','تخصيص الحجوزات بناءً على تفضيلاتك','تقديم توصيات مناسبة لمساعدتك','الرد على استفساراتك بشكل أفضل','تطوير خدمات خدمة مستلزمات الحجز الإلكتروني والمدفوعة الرقمية']),
            ),
            SizedBox(height: 16.h),
            _NumberedSection(number: '٣', title: 'مشاركة المعلومات',
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                _BodyText('نحن لا ننقل أو نبيع بيانات المستخدمين إلى أي جهات خارجية، إلا في الحالات التالية فقط:'),
                SizedBox(height: 8.h),
                _BulletList(items: const ['إذا كان ذلك مطلوبًا قانونًا','الحصول على خدمات من خلال توفير: تحليل تفاعلي معنّا','الحصول المؤهل لخدمات Google أو خدمات تجارية فاعلة','في وجود موافقة مسبقة ومريحة من المستخدم','في إجراءات ذاتية المتعلق والشركاء دون إخبارك']),
              ]),
            ),
            SizedBox(height: 16.h),
            _NumberedSection(number: '٤', title: 'ملفات تعريف الارتباط (Cookies)',
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                _BodyText('نستخدم ملفات تعريف الارتباط لتحسين تجربة التصفح مثل:'),
                SizedBox(height: 8.h),
                _BulletList(items: const ['حفظ تفضيلاتك وإعداداتك','تسريع عمليات البحث','عرض المحتوى بناءً على اهتماماتك']),
                SizedBox(height: 8.h),
                _BodyText('يمكنك التحكم في الكوكيز من إعدادات المتصفح، مع ملاحظة أن بعض الخصائص قد لا تعمل بكل كفاءة.'),
              ]),
            ),
            SizedBox(height: 16.h),
            _NumberedSection(number: '٥', title: 'حماية البيانات',
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                _BodyText('نستخدم مجموعة من الإجراءات الأمنية لحماية بياناتك:'),
                SizedBox(height: 8.h),
                _BulletList(items: const ['تشفير الاتصال عبر HTTPS','تخزين البيانات على قواعد بيانات آمنة','مع الوصول غير المرخص به','مراجعة دورية لأنظمة الأمان']),
                SizedBox(height: 8.h),
                _BodyText('ومع ذلك، لا يمكن لأي نظام أمان ضمان حماية 100%، لكننا نسعى دائمًا إلى مستوى الأمان.'),
              ]),
            ),
            SizedBox(height: 16.h),
            _NumberedSection(number: '٦', title: 'حقوق المستخدم',
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                _BodyText('لديك الحق في:'),
                SizedBox(height: 8.h),
                _BulletList(items: const ['الوصول إلى بياناتك وتصحيح أخطائها','طلب تعديل أو حذف بياناتك','إيقاف استقبال الإشعارات أو الاتصال','حذف حسابك كاملاً من المنصة']),
              ]),
            ),
            SizedBox(height: 16.h),
            _NumberedSection(number: '٧', title: 'التعديلات على سياسة الخصوصية',
              child: _BodyText('قد نقوم بتحديث هذه الصفحة من وقت لآخر.\nسنسعى إلى إخطارك بهذه التغييرات عبر تغيير تاريخ آخر تحديث.\nنوصيك بالتأكد من كيفية حصول جمهورنا على طريقة استخدام معلوماتك.'),
            ),
            SizedBox(height: 16.h),
            _NumberedSection(number: '٨', title: 'كيفية التواصل معنا',
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                _BodyText('إذا كان لديك أي سؤال حول سياسة الخصوصية يمكنك التواصل معنا عبر:'),
                SizedBox(height: 10.h),
                _ContactRow(icon: Icons.email_outlined, text: 'example@gmail.com'),
              ]),
            ),
            SizedBox(height: 20.h),
            _LastUpdated(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

// ── Intro card (branded gradient — intentionally static in both themes) ────────

class _IntroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D2B3E), Color(0xFF4A4766)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D2B3E).withOpacity(0.22),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text('سياسة الخصوصية',
                style: AppTextStyles.font20BoldShadowPurple(context)
                    .copyWith(color: Colors.white)),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.all(7.r),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
              child: Icon(Icons.privacy_tip_outlined, color: Colors.white, size: 20.sp),
            ),
          ]),
          SizedBox(height: 10.h),
          Text(
            'مرحبًا بك في منصة فندقي. نحن نلتزم بحماية خصوصيتك واحترام بياناتك الشخصية '
            'ونسعى لتوفير تجربة آمنة وشفافة لجميع مستخدمي منصتنا.',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.font14RegularNightfall(context)
                .copyWith(color: Colors.white.withOpacity(0.85), height: 1.7),
          ),
        ],
      ),
    );
  }
}

// ── Numbered section card ─────────────────────────────────────────────────────

class _NumberedSection extends StatelessWidget {
  final String number;
  final String title;
  final Widget child;
  const _NumberedSection({required this.number, required this.title, required this.child});

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
            color: isLight ? Colors.black.withOpacity(0.045) : Colors.transparent,
            blurRadius: 8, offset: const Offset(0, 3),
          ),
        ],
        border: isLight ? null : Border.all(color: cs.outline, width: 0.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(title,
              style: AppTextStyles.font18BoldGray(context).copyWith(fontSize: 16.sp)),
          SizedBox(width: 10.w),
          Container(
            width: 32.r, height: 32.r,
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(number,
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ]),
        SizedBox(height: 10.h),
        Divider(height: 1, color: cs.outline),
        SizedBox(height: 14.h),
        child,
      ]),
    );
  }
}

// ── Sub-title ─────────────────────────────────────────────────────────────────

class _SubTitle extends StatelessWidget {
  final String text;
  const _SubTitle(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      textDirection: TextDirection.rtl,
      style: AppTextStyles.font14RegularNightfall(context)
          .copyWith(fontWeight: FontWeight.w600, color: AppColors.primary));
}

// ── Body text ─────────────────────────────────────────────────────────────────

class _BodyText extends StatelessWidget {
  final String text;
  const _BodyText(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: AppTextStyles.font14RegularNightfall(context).copyWith(height: 1.8));
}

// ── Bullet list ───────────────────────────────────────────────────────────────

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({required this.items});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: items.map((item) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            Expanded(child: Text(item,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: AppTextStyles.font14RegularNightfall(context).copyWith(height: 1.7))),
            SizedBox(width: 10.w),
            Padding(
              padding: EdgeInsets.only(top: 7.h),
              child: Container(width: 6.r, height: 6.r,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

// ── Contact row ───────────────────────────────────────────────────────────────

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          Text(text, style: AppTextStyles.font14RegularNightfall(context)
              .copyWith(color: AppColors.primary, fontWeight: FontWeight.w500)),
          SizedBox(width: 8.w),
          Icon(icon, color: AppColors.primary, size: 18.sp),
        ],
      ),
    );
  }
}

// ── Last updated ──────────────────────────────────────────────────────────────

class _LastUpdated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          // surfaceContainerHighest = neutral tinted chip in both themes.
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text('آخر تحديث: ٢٠ نوفمبر ٢٠٢٥',
            textDirection: TextDirection.rtl,
            style: AppTextStyles.font12RegularDisabled(context)),
      ),
    );
  }
}
