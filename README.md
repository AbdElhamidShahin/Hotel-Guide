<div align="center">

# 🏨 Hotel Guide

### A production-grade Hotel Booking & Management App built with Flutter 🚀

<p>
  <img src="[https://img.shields.io/badge/Flutter-3.0-blue?style=for-the-badge&logo=flutter](https://img.shields.io/badge/Flutter-3.0-blue?style=for-the-badge&logo=flutter)"/>
  <img src="[https://img.shields.io/badge/Architecture-Clean%20Architecture-green?style=for-the-badge](https://img.shields.io/badge/Architecture-Clean%20Architecture-green?style=for-the-badge)"/>
  <img src="[https://img.shields.io/badge/State-BLoC-purple?style=for-the-badge](https://img.shields.io/badge/State-BLoC-purple?style=for-the-badge)"/>
  <img src="[https://img.shields.io/badge/Payments-Stripe-blue?style=for-the-badge&logo=stripe](https://img.shields.io/badge/Payments-Stripe-blue?style=for-the-badge&logo=stripe)"/>
  <img src="[https://img.shields.io/badge/Backend-Supabase-black?style=for-the-badge&logo=supabase](https://img.shields.io/badge/Backend-Supabase-black?style=for-the-badge&logo=supabase)"/>
</p>

</div>

---

## ✨ Overview

**Hotel Guide** is a modern hotel booking application built using Flutter, designed with scalability and real-world production architecture.

It provides a seamless experience for booking hotels, managing payments, chatting with an AI assistant, and handling user wallets.

---

## 🚀 Key Features

### 🏨 Hotel Booking System
- Browse hotels & rooms with advanced filtering.
- Detailed hotel profiles, room availability, and pricing.
- Smart, multi-step booking flow.
- Comprehensive booking history tracking.

### 💳 Secure Payments (Stripe)
- Full Stripe Payment Sheet integration.
- Secure payment intents & ephemeral keys handling.
- Real-time transaction validation and booking confirmation.

### 💰 Wallet System
- In-app user balance management.
- Secure top-up functionality.
- Detailed transaction history & instant refund support.

### 🤖 AI Booking Assistant
- Smart chat assistant for tailored recommendations.
- Webhook-based architecture (n8n / automation tools).
- Context-aware responses based on user preferences.

### ❤️ Core Modules
- **Favorites System:** Save and quick-access preferred hotels.
- **Notifications:** Real-time updates for booking and payment statuses.
- **Authentication:** Supabase Auth integration supporting Email/Password, Google Sign-In, and Facebook (UI Ready).

---

## 🧠 Architecture & Tech Stack

This project strictly follows **Clean Architecture** combined with a **Feature-Based Structure** to ensure maximum maintainability and testability.

```text
lib/
├── core/                  # Shared components (network, theme, router, helpers)
├── features/              # Feature modules (auth, booking, payment, etc.)
│   └── [feature_name]/
│       ├── data/          # Models, Repositories implementations, Data sources
│       ├── domain/        # Entities, Use cases, Repository interfaces
│       └── presentation/  # BLoC/Cubit, Screens, Widgets
└── main.dart
🛠 Tech Stack Details
State Management: BLoC / Cubit for predictable state transitions.

Navigation: GoRouter (Declarative routing mechanism).

Backend Service: Supabase (Database + Authentication).

Payment Gateway: Stripe Payments.

Responsive UI: ScreenUtil with Google Fonts (Cairo).

📸 Screenshots
(Note: You can check the rest of the app views inside the /screenshots directory)

⚙️ Installation & Setup
1️⃣ Clone the Repository
Bash
git clone https://github.com/your-username/hotel-guide.git
cd hotel-guide 
2️⃣ Install Dependencies
Bash
flutter pub get
3️⃣ Configure Environment Credentials
Create a configuration file at lib/core/network/api_constants.dart (Make sure to exclude sensitive keys from version control):

Dart
class ApiConstants {
  static const String supabaseUrl = "YOUR_SUPABASE_URL";
  static const String supabaseKey = "YOUR_SUPABASE_KEY";
  static const String stripePublishableKey = "YOUR_STRIPE_PUBLISHABLE_KEY";
}
4️⃣ Run the Project
Bash
flutter run
🔄 Integration Flows
💳 Stripe Payment Lifecycle
Create Payment Intent: Triggered via secure backend/edge functions.

Generate Ephemeral Key: Issued to manage customer state safely.

Attach Customer: Links the Stripe customer ID dynamically.

Present Payment Sheet: Native SDK UI overlay for card details.

Confirm Transaction: Success callback updates the database status.

🤖 Webhook AI Chat
Standardized payload sent to an external workflow automation service (e.g., n8n).

Processes constraints, availability, and specific context.

Streamlined JSON responses parsed directly within the chat UI block.

🎯 Business Value
This portfolio asset encapsulates production-grade competencies:

Architecture Scalability: Separation of concerns ensures multiple developers can target features concurrently.

Financial Compliance: Relying on approved Stripe tokenization patterns avoiding direct PPI exposure.

Modern User Experience: Combining automation (AI Chat) with fluid responsiveness to decrease booking friction.

📈 SEO Keywords
Flutter • Hotel Booking App • Stripe Payment Flutter • Supabase Flutter • AI Chat Flutter • Clean Architecture Flutter • BLoC Flutter • Travel App Flutter
