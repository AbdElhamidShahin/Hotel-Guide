<div align="center">

# Hotel Guide

A full-featured hotel booking app built with Flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.8+-blue?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue?style=flat-square&logo=dart)](https://dart.dev)
[![Supabase](https://img.shields.io/badge/Backend-Supabase-3ECF8E?style=flat-square&logo=supabase)](https://supabase.com)
[![Stripe](https://img.shields.io/badge/Payments-Stripe-635BFF?style=flat-square&logo=stripe)](https://stripe.com)

</div>

---

## Overview

Hotel Guide is a Flutter app that lets users browse hotels, check availability, and complete bookings with real payment processing. The project is built on Clean Architecture with a feature-based folder structure, making it easy to scale and maintain.

---

## Screenshots

<table>
  <tr>
    <td align="center"><b>Onboarding</b></td>
    <td align="center"><b>Login</b></td>
    <td align="center"><b>Register</b></td>
  </tr>
  <tr>
    <td><img src="screenshots/onboarding.png" width="200"/></td>
    <td><img src="screenshots/login.png" width="200"/></td>
    <td><img src="screenshots/register.png" width="200"/></td>
  </tr>
  <tr>
    <td align="center"><b>Home</b></td>
    <td align="center"><b>Search & Filter</b></td>
    <td align="center"><b>Hotel Details</b></td>
  </tr>
  <tr>
    <td><img src="screenshots/home.png" width="200"/></td>
    <td><img src="screenshots/search.png" width="200"/></td>
    <td><img src="screenshots/hotel_details.png" width="200"/></td>
  </tr>
  <tr>
    <td align="center"><b>Booking</b></td>
    <td align="center"><b>Payment</b></td>
    <td align="center"><b>Wallet</b></td>
  </tr>
  <tr>
    <td><img src="screenshots/booking.png" width="200"/></td>
    <td><img src="screenshots/payment.png" width="200"/></td>
    <td><img src="screenshots/wallet.png" width="200"/></td>
  </tr>
  <tr>
    <td align="center"><b>AI Assistant</b></td>
    <td align="center"><b>Profile</b></td>
    <td align="center"><b>Notifications</b></td>
  </tr>
  <tr>
    <td><img src="screenshots/ai_chat.png" width="200"/></td>
    <td><img src="screenshots/profile.png" width="200"/></td>
    <td><img src="screenshots/notifications.png" width="200"/></td>
  </tr>
</table>

---

## Features

- **Onboarding** — intro screens for new users
- **Auth** — sign up, log in, and Facebook login
- **Hotel Browsing** — browse hotels with ratings, photos, and details
- **Search & Filter** — filter by availability, price, and rating
- **Booking Flow** — multi-step booking with date picker and room selection
- **Stripe Payments** — secure card payments using Stripe's native sheet
- **Wallet** — top up balance, track transactions, and handle refunds
- **AI Assistant** — chat assistant powered by n8n webhooks with hotel context
- **Notifications** — booking status updates
- **Offline Handling** — connectivity check with user feedback

---

## Architecture

The project follows **Clean Architecture** with a feature-based structure.

```
lib/
├── core/                    # Shared utilities, theme, router, DI
│   ├── network/
│   ├── router/
│   └── di/
└── features/
    └── [feature]/
        ├── data/            # Models, data sources, repository implementations
        ├── domain/          # Entities, use cases, repository interfaces
        └── presentation/    # BLoC/Cubit, screens, widgets
```

---

## Tech Stack

| Area | Technology |
|------|-----------|
| Framework | Flutter 3.8+ |
| State Management | BLoC / Cubit |
| Navigation | GoRouter |
| Backend & Auth | Supabase |
| Payments | Stripe |
| AI Integration | n8n Webhooks |
| Responsive UI | ScreenUtil |
| Local Storage | SharedPreferences |
| HTTP Client | Dio |
| DI | GetIt |

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.8.1`
- A [Supabase](https://supabase.com) project
- A [Stripe](https://stripe.com) account

### Installation

```bash
git clone https://github.com/AbdElhamidShahin/Hotel-Guide.git
cd Hotel-Guide
flutter pub get
flutter run
```

### Environment Setup

Create the following file and add your keys:

```dart
// lib/core/network/api_constants.dart
abstract class ApiConstants {
  static const String supabaseUrl = "YOUR_SUPABASE_URL";
  static const String supabaseKey = "YOUR_SUPABASE_KEY";
  static const String stripePublishableKey = "YOUR_STRIPE_KEY";
}
```

---

## Payment Flow

```
App  →  Supabase Edge Function  →  Stripe API
               ↓
     Returns Client Secret + Ephemeral Key
               ↓
     Native Stripe Sheet shown to user
               ↓
     On success → Webhook updates booking in DB
```

---

## Developer

**Abd Elhamid Shahin** — [GitHub](https://github.com/AbdElhamidShahin)
