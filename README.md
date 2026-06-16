<div align="center">

# 🏨 Hotel Guide

### A production-grade Hotel Booking & Management App built with Flutter 🚀

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-green?style=for-the-badge)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![State Management](https://img.shields.io/badge/State-BLoC%20%2F%20Cubit-purple?style=for-the-badge)](https://bloclibrary.dev)
[![Payments](https://img.shields.io/badge/Payments-Stripe-indigo?style=for-the-badge&logo=stripe)](https://stripe.com)
[![Backend](https://img.shields.io/badge/Backend-Supabase-black?style=for-the-badge&logo=supabase)](https://supabase.com)

</div>

---

## ✨ Overview

**Hotel Guide** ليس مجرد تطبيق حجز تقليدي، بل هو نظام متكامل مصمم لمحاكاة البيئات الإنتاجية الضخمة (Production-Grade). يركز المشروع بشكل أساسي على **Architecture Scalability** وقابلية الفحص والصيانة، من خلال دمج منظومة دفع حقيقية، محفظة مالية رقمية متكاملة، ومساعد ذكي مدعوم بالذكاء الاصطناعي عبر أتمتة الـ Webhooks.

---

## 🚀 Key Modules & Engineering Depth

### 🏨 Booking Core
* **Advanced Filtering:** نظام تصفية ذكي يعتمد على التوافر الفعلي، الأسعار، وتقييمات الغرف.
* **Smart Step-Flow:** تجربة مستخدم (UX) مرنة لإتمام الحجز تضمن تماسك البيانات (Data Integrity) قبل الانتقال لخطوة الدفع.

### 💳 Stripe Infrastructure
* **Zero PPI Exposure:** الاعتماد الكلي على نظام التشفير (Tokenization) الخاص بـ Stripe دون تخزين أي بيانات حساسة للبطاقات.
* **Stateful Sessions:** إدارة دورة حياة عملية الدفع بالكامل عبر المزامنة بين `Payment Intent` والـ `Ephemeral Keys`.

### 💰 Wallet Engine
* **Ledger-Based Analytics:** سجل عمليات صارم لتتبع عمليات الشحن (Top-up)، الخصم المباشر، والدعم الفوري لعمليات الارتجاع (Refunds) لضمان دقة الرصيد.

### 🤖 Webhook-Driven AI Assistant
* **Decoupled AI Engine:** بدلاً من ربط التطبيق مباشرة بـ APIs مكلفة، يعتمد التطبيق على بنية تحتية مرنة ترسل طلبات المستخدم إلى نظام أتمتة خارجي (`n8n` Webhooks)، ليعود برصيد إجابات ديناميكي ومخصص وفقًا لحالة الفنادق المتاحة.

---

## 🧠 Software Architecture

يتبنى المشروع نمط **Clean Architecture** مدمجًا مع تقسيم قائم على الميزات (**Feature-Based Structure**)، مما يفصل تمامًا بين منطق العمل (Business Logic) وواجهات المستخدم.

```text
lib/
├── core/                  # Shared infrastructure (Network, Theme, Router, DI)
└── features/              # Modular Domain Features
    └── [feature_name]/    
        ├── data/          # Models, API Data Sources, Repository Implementations
        ├── domain/        # Entities, Use Cases, Repository Contracts (Interfaces)
        └── presentation/  # State Management (BLoC/Cubit), Screens, UI Widgets

🛠 Technical SpecificationsCategoryTechnology UsedArchitectural PurposeState ManagementBLoC / CubitUnidirectional Data Flow & Predictable StatesRoutingGoRouterDeclarative deep-linking & sub-routes handlingBackend / AuthSupabasePostgreSQL Real-time engine & secure JWT AuthResponsive UIScreenUtilDynamic pixel scaling across varying aspect ratios

🔄 Technical Integration Flows
💳 Payment Lifecycle Sequence
[App UI] ──(1. Initiate)──> [Supabase Edge Function] ──(2. Create Intent)──> [Stripe API]
   │                                                                             │
   │<───────────────(3. Return Ephemeral Key & Client Secret)────────────────────┘
   │
   └──(4. Present Native Sheet)──> [User Confirms] ──(5. Webhook Update)──> [DB Booking Success]
🤖 AI Workflow (n8n Integration)Design Pattern: يعتمد نظام المحادثة على الـ Stateless Webhooks لتمرير سياق البحث الخاص بالمستخدم (Context-Aware Queries)، معالجة القيود عبر الـ Workflow، ثم استقبال البيانات على هيئة Structured JSON يتم صياغته فوريًا داخل الـ Chat UI.📸 ScreenshotsHome & ExploreHotel DetailsSmooth BookingSecure CheckoutAI AssistantDigital WalletSettings & ProfileBooking History⚙️ Environment Setup & Installation1. Repository SetupBashgit clone [https://github.com/your-username/hotel-guide.git](https://github.com/your-username/hotel-guide.git)
cd hotel-guide
flutter pub get
2. Infrastructure Configurationقم بإنشاء ملف الإعدادات داخل المسار التالي لمنع تسريب المفاتيح الحساسة إلى نظام تعقب الملفات (Git):lib/core/network/api_constants.dartDartabstract class ApiConstants {
  static const String supabaseUrl = "YOUR_SUPABASE_URL";
  static const String supabaseKey = "YOUR_SUPABASE_KEY";
  static const String stripePublishableKey = "YOUR_STRIPE_PUBLISHABLE_KEY";
}
3. ExecutionBashflutter run
---

## 📸 Screenshots

<div align="center">
  <table>
    <tr>
      <th>Home & Explore</th>
      <th>Hotel Details</th>
      <th>Smooth Booking</th>
      <th>Secure Checkout</th>
    </tr>
    <tr>
<img width="1080" height="2424" alt="Screenshot_20260502_150914" src="https://github.com/user-attachments/assets/06df0aba-d9c4-4b47-b4cf-3f560ec9671d" />
<img width="1080" height="2424" alt="Screenshot_20260502_150914 - Copy" src="https://github.com/user-attachments/assets/689324ec-24f4-4580-95f5-544d881c5a5a" />
<img width="1080" height="2424" alt="Screenshot_20260502_150903" src="https://github.com/user-attachments/assets/37a940cc-a5e1-4cd7-b24b-6abdb499456c" />
<img width="1080" height="2424" alt="Screenshot_20260502_150854" src="https://github.com/user-attachments/assets/900bf882-e062-464d-851b-aae36d3ab0b5" />
<img width="1080" height="2424" alt="Screenshot_20260502_150819" src="https://github.com/user-attachments/assets/a0522759-ebfe-452b-b845-f5f88fe3afff" />

    </tr>
    <tr>
      <th>AI Assistant</th>
      <th>Digital Wallet</th>
      <th>Settings & Profile</th>
      <th>Booking History</th>
    </tr>
    <tr>

<img width="1080" height="2424" alt="Screenshot_20260502_151054 - Copy" src="https://github.com/user-attachments/assets/f5aedffa-ba7a-443c-b56d-a2b0f00a0f84" />
<img width="1080" height="2424" alt="Screenshot_20260502_151036 - Copy" src="https://github.com/user-attachments/assets/a86c9f85-82c5-4d7d-a3e4-a928d7068d5d" />

    </tr>
  </table>
</div>
![Uploading Screenshot_20260502_151318.png…]()
<img width="1080" height="2424" alt="Screenshot_20260502_151247 - Copy" src="https://github.com/user-attachments/assets/362d17f7-35eb-4a5e-816e-d3d6067d3b64" />
<img width="1080" height="2424" alt="Screenshot_20260502_152051" src="https://github.com/user-attachments/assets/29195264-687f-47b5-a627-3a276d2bd1a3" />
<img width="1080" height="2424" alt="Screenshot_20260502_152037" src="https://github.com/user-attachments/assets/7e5ead33-1116-42a6-8c09-cf314af7f9ab" />
<img width="1080" height="2424" alt="Screenshot_20260502_152025" src="https://github.com/user-attachments/assets/28f7e27b-d3ce-464d-8cb2-685333dc1029" />
<img width="1080" height="2424" alt="Screenshot_20260502_151237 - Copy" src="https://github.com/user-attachments/assets/ddadf671-5568-43c5-be97-24e4065b1860" />
<img width="1080" height="2424" alt="Screenshot_20260502_151223" src="https://github.com/user-attachments/assets/8c619b8a-30bf-4b47-912a-432d5ff5af8c" />
<img width="1080" height="2424" alt="Screenshot_20260502_151223 - Copy" src="https://github.com/user-attachments/assets/69ab1f0e-a27c-48e9-ae3a-9ae59248edaa" />
<img width="1080" height="2424" alt="Screenshot_20260502_151210" src="https://github.com/user-attachments/assets/2b2d1860-5e1b-4cd0-b563-d743572222a6" />
<img width="1080" height="2424" alt="Screenshot_20260502_151105 - Copy" src="https://github.com/user-attachments/assets/29b1194a-c15c-411b-ad94-154b9153b3d3" />

---
