import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FC),
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
            // ── Intro ─────────────────────────────────────────────────
            _IntroCard(),
            SizedBox(height: 20.h),

            // ── Sections ───────────────────────────────────────────────
            _NumberedSection(
              number: '١',
              title: 'المعلومات التي نقوم بجمعها',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _SubTitle('أولاً: المعلومات التي يقدمها المستخدم بنفسه'),
                  SizedBox(height: 6.h),
                  _BulletList(
                    items: const [
                      'الاسم',
                      'البريد الإلكتروني',
                      'رقم الهاتف',
                      'صورة الملف الشخصي (إن وُجد)',
                      'وكل ما لا نطلب أي معلومات خارج مصادر الأعمال',
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _SubTitle('ثانياً: المعلومات التي يتم جمعها تلقائياً'),
                  SizedBox(height: 6.h),
                  _BulletList(
                    items: const [
                      'نوع الجهاز والمتصفح',
                      'عنوان IP',
                      'الصفحات التي تم زيارتها على الموقع',
                      'مدة بقائك داخل المنصة',
                      'ملفات تعريف الارتباط (Cookies للتحسين الذاتي)',
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            _NumberedSection(
              number: '٢',
              title: 'استخدام المعلومات',
              child: _BulletList(
                items: const [
                  'تحسين تجربة الحجز وتطوير المنصة',
                  'تخصيص الحجوزات بناءً على تفضيلاتك',
                  'تقديم توصيات مناسبة لمساعدتك',
                  'الرد على استفساراتك بشكل أفضل',
                  'تطوير خدمات خدمة مستلزمات الحجز الإلكتروني والمدفوعة الرقمية',
                ],
              ),
            ),

            SizedBox(height: 16.h),

            _NumberedSection(
              number: '٣',
              title: 'مشاركة المعلومات',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'نحن لا ننقل أو نبيع بيانات المستخدمين إلى أي جهات خارجية، إلا في الحالات التالية فقط:',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: _bodyStyle(),
                  ),
                  SizedBox(height: 8.h),
                  _BulletList(
                    items: const [
                      'إذا كان ذلك مطلوبًا قانونًا',
                      'الحصول على خدمات من خلال توفير: تحليل تفاعلي معنّا',
                      'الحصول المؤهل لخدمات Google أو خدمات تجارية فاعلة',
                      'في وجود موافقة مسبقة ومريحة من المستخدم',
                      'في إجراءات ذاتية المتعلق والشركاء دون إخبارك',
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            _NumberedSection(
              number: '٤',
              title: 'ملفات تعريف الارتباط (Cookies)',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'نستخدم ملفات تعريف الارتباط لتحسين تجربة التصفح مثل:',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: _bodyStyle(),
                  ),
                  SizedBox(height: 8.h),
                  _BulletList(
                    items: const [
                      'حفظ تفضيلاتك وإعداداتك',
                      'تسريع عمليات البحث',
                      'عرض المحتوى بناءً على اهتماماتك',
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'يمكنك التحكم في الكوكيز من إعدادات المتصفح، مع ملاحظة أن بعض الخصائص قد لا تعمل بكل كفاءة.',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: _bodyStyle(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            _NumberedSection(
              number: '٥',
              title: 'حماية البيانات',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'نستخدم مجموعة من الإجراءات الأمنية لحماية بياناتك:',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: _bodyStyle(),
                  ),
                  SizedBox(height: 8.h),
                  _BulletList(
                    items: const [
                      'تشفير الاتصال عبر HTTPS',
                      'تخزين البيانات على قواعد بيانات آمنة',
                      'مع الوصول غير المرخص به',
                      'مراجعة دورية لأنظمة الأمان',
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'ومع ذلك، لا يمكن لأي نظام أمان ضمان حماية 100%، لكننا نسعى دائمًا إلى مستوى الأمان.',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: _bodyStyle(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            _NumberedSection(
              number: '٦',
              title: 'حقوق المستخدم',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'لديك الحق في:',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: _bodyStyle(),
                  ),
                  SizedBox(height: 8.h),
                  _BulletList(
                    items: const [
                      'الوصول إلى بياناتك وتصحيح أخطائها',
                      'طلب تعديل أو حذف بياناتك',
                      'إيقاف استقبال الإشعارات أو الاتصال',
                      'حذف حسابك كاملاً من المنصة',
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            _NumberedSection(
              number: '٧',
              title: 'التعديلات على سياسة الخصوصية',
              child: Text(
                'قد نقوم بتحديث هذه الصفحة من وقت لآخر.\n'
                'سنسعى إلى إخطارك بهذه التغييرات عبر تغيير تاريخ آخر تحديث.\n'
                'نوصيك بالتأكد من كيفية حصول جمهورنا على طريقة استخدام معلوماتك.',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: _bodyStyle(),
              ),
            ),

            SizedBox(height: 16.h),

            _NumberedSection(
              number: '٨',
              title: 'كيفية التواصل معنا',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'إذا كان لديك أي سؤال حول سياسة الخصوصية يمكنك التواصل معنا عبر:',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: _bodyStyle(),
                  ),
                  SizedBox(height: 10.h),
                  _ContactRow(
                    icon: Icons.email_outlined,
                    text: 'example@gmail.com',
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // ── Last updated ──────────────────────────────────────────
            _LastUpdated(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  TextStyle _bodyStyle() => TextStyle(
    fontSize: 13.5.sp,
    fontFamily: 'Cairo',
    color: const Color(0xFF555566),
    height: 1.8,
  );
}

// ── Intro card ────────────────────────────────────────────────────────────────

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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'سياسة الخصوصية',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.all(7.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'مرحبًا بك في منصة فندقي. نحن نلتزم بحماية خصوصيتك واحترام بياناتك الشخصية '
            'ونسعى لتوفير تجربة آمنة وشفافة لجميع مستخدمي منصتنا.',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 13.sp,
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

// ── Numbered section ──────────────────────────────────────────────────────────

class _NumberedSection extends StatelessWidget {
  final String number;
  final String title;
  final Widget child;

  const _NumberedSection({
    required this.number,
    required this.title,
    required this.child,
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
            color: Colors.black.withOpacity(0.045),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Title row with number badge
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1F3C),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),
          Container(height: 1, color: const Color(0xFFEEEEF5)),
          SizedBox(height: 14.h),

          child,
        ],
      ),
    );
  }
}

// ── Sub-title ─────────────────────────────────────────────────────────────────

class _SubTitle extends StatelessWidget {
  final String text;
  const _SubTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontSize: 14.sp,
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
    );
  }
}

// ── Bullet list ───────────────────────────────────────────────────────────────

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
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
                    height: 1.7,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Padding(
                padding: EdgeInsets.only(top: 7.h),
                child: Container(
                  width: 6.r,
                  height: 6.r,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
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
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Cairo',
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
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
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEF5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          'آخر تحديث: ٢٠ نوفمبر ٢٠٢٥',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'Cairo',
            color: const Color(0xFF888899),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
