# 🏨 Hotel Guide

تطبيق موبايل متكامل مبني بـ **Flutter** يساعد المستخدمين على اكتشاف الفنادق، استعراض تفاصيلها، وإتمام الحجز بسهولة — كل ده في مكان واحد.

---

## 📸 Screenshots

### Onboarding

<img width="1080" height="2424" alt="Screenshot_20260502_150854" src="https://github.com/user-attachments/assets/5cc0edd4-ebaf-452b-a481-023fda3b111d" />
<img width="1080" height="2424" alt="Screenshot_20260502_150819" src="https://github.com/user-attachments/assets/c71a8d5d-bec0-47da-8a6b-21d000d30756" />
<img width="1080" height="2424" alt="Screenshot_20260502_150903" src="https://github.com/user-attachments/assets/cc522121-e88b-403c-81f8-f9d5d6980f16" />


---

### Authentication



<img width="1080" height="2424" alt="Screenshot_20260502_150914" src="https://github.com/user-attachments/assets/8cd47224-4a54-45ee-88ce-79f3d6e9c39f" />


---

### Home & Discovery
<img width="1080" height="2424" alt="Screenshot_20260502_151210" src="https://github.com/user-attachments/assets/27f70339-5cf9-4f54-840c-644fbba7c22b" />
<img width="1080" height="2424" alt="Screenshot_20260502_151054 - Copy" src="https://github.com/user-attachments/assets/c0e21dbe-2975-458e-b76f-e4cf76e9d354" />
<img width="1080" height="2424" alt="Screenshot_20260502_151036 - Copy" src="https://github.com/user-attachments/assets/779f5fa9-78a4-420a-85e7-453f38283063" />
<img width="1080" height="2424" alt="Screenshot_20260502_151223 - Copy" src="https://github.com/user-attachments/assets/32c8418c-ed48-4ce3-856c-20abda4a1558" />

---

### Hotel Details & Booking

<img width="1080" height="2424" alt="Screenshot_20260502_151352" src="https://github.com/user-attachments/assets/1d048b18-c72e-457c-8176-153d65556b0f" />
<img width="1080" height="2424" alt="Screenshot_20260502_151343" src="https://github.com/user-attachments/assets/e8396c3d-1c9b-4b53-ac3a-6c4a6397d883" />

<img width="1080" height="2424" alt="Screenshot_20260502_151318" src="https://github.com/user-attachments/assets/1131ad4b-e144-4f0f-affd-9bc8761579ec" />
<img width="1080" height="2424" alt="Screenshot_20260502_151413" src="https://github.com/user-attachments/assets/4d5928dd-05e1-4627-8760-1ef25a14342b" />
<img width="1080" height="2424" alt="Screenshot_20260502_151403" src="https://github.com/user-attachments/assets/c64c6aa7-233c-4e8d-8ff2-027b0b00cbf6" />
<img width="1080" height="2424" alt="Screenshot_20260502_151333" src="https://github.com/user-attachments/assets/2452f639-bf93-4898-8d24-c80db5020967" />


### Profile & Notifications

| البروفايل | الإشعارات |
<img width="1080" height="2424" alt="Screenshot_20260502_152025 - Copy" src="https://github.com/user-attachments/assets/f347840b-a2a4-4882-a44d-266b1f77adab" />
<img width="1080" height="2424" alt="Screenshot_20260502_151831" src="https://github.com/user-attachments/assets/a1c8d9c4-86b3-4629-aeec-2e2d516defea" />


## ✨ المميزات

- **Onboarding** — شاشات ترحيب للمستخدمين الجدد
- **تسجيل الدخول / إنشاء حساب** — مع دعم تسجيل الدخول عبر Facebook
- **استعراض الفنادق** — عرض الفنادق مع التقييمات والتفاصيل الكاملة
- **البحث والفلترة** — إيجاد الفندق المناسب بسهولة
- **حجز الغرف** — اختيار التواريخ والغرف وإتمام الحجز
- **الدفع الإلكتروني** — بوابة دفع آمنة عبر Stripe
- **المشاركة** — مشاركة الفنادق مع الأصحاب
- **الإشعارات** — متابعة حالة الحجوزات
- **الوضع بدون إنترنت** — مراقبة حالة الاتصال وإبلاغ المستخدم

---

## 🛠️ التقنيات المستخدمة

| التقنية | الاستخدام |
|---------|----------|
| **Flutter** | إطار العمل الأساسي للتطبيق |
| **Dart** | لغة البرمجة |
| **Supabase** | قاعدة البيانات والـ Backend |
| **flutter_bloc** | إدارة الـ State |
| **go_router** | التنقل بين الشاشات |
| **Stripe** | معالجة المدفوعات |
| **Firebase** | خدمات إضافية |
| **get_it** | Dependency Injection |
| **dio / http** | طلبات الـ API |
| **shared_preferences** | تخزين البيانات محلياً |
| **table_calendar** | التقويم لاختيار تواريخ الحجز |
| **image_picker** | رفع صور البروفايل |

---

## 🏗️ هيكل المشروع

```
hotel_guide/
├── lib/                  # الكود الأساسي للتطبيق
├── assets/
│   ├── images/           # الصور والـ Logo
│   ├── icons/            # الأيقونات
│   ├── fonts/            # خط Cairo
│   └── Onpording/        # صور شاشات الـ Onboarding
├── android/              # إعدادات Android
├── ios/                  # إعدادات iOS
├── web/                  # دعم الويب
└── supabase/             # إعدادات Supabase
```

---

## 🚀 تشغيل المشروع

### المتطلبات

- Flutter SDK `^3.8.1`
- Dart SDK
- حساب على [Supabase](https://supabase.com)
- حساب على [Stripe](https://stripe.com) للمدفوعات

### خطوات التشغيل

```bash
# 1. استنسخ الريبو
git clone https://github.com/AbdElhamidShahin/Hotel-Guide.git
cd Hotel-Guide

# 2. ثبّت الـ dependencies
flutter pub get

# 3. شغّل الـ splash screen
dart run flutter_native_splash:create

# 4. شغّل التطبيق
flutter run
```

---

## ⚙️ إعداد المتغيرات البيئية

قبل ما تشغّل التطبيق، لازم تضيف بيانات الاتصال بتاعتك في الملف المناسب:

```dart
// Supabase
const supabaseUrl = 'YOUR_SUPABASE_URL';
const supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

// Stripe
const stripePublishableKey = 'YOUR_STRIPE_PUBLISHABLE_KEY';
```

---

## 📦 الـ Packages الرئيسية

```yaml
flutter_bloc: ^9.1.1        # State Management
go_router: ^16.2.4          # Navigation
supabase_flutter: ^2.12.0   # Backend
flutter_stripe: ^11.1.0     # Payments
flutter_screenutil: ^5.9.3  # Responsive UI
table_calendar: ^3.2.0      # Date Picker
flutter_facebook_auth: ^7.1.5
connectivity_plus: ^7.0.0
share_plus: ^12.0.1
dio: ^5.9.2
```

---

## 👨‍💻 المطوّر

**Abd Elhamid Shahin**

[![GitHub](https://img.shields.io/badge/GitHub-AbdElhamidShahin-181717?style=flat&logo=github)](https://github.com/AbdElhamidShahin)

---

## 📄 الرخصة

This project is for educational and portfolio purposes.
