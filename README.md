<div align="center">

# Hotel Guide

A full-featured hotel booking app built with Flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.8+-blue?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%5E3.8.1-blue?style=flat-square&logo=dart)](https://dart.dev)
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
    <td align="center"><b></b></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/705d50b2-6087-4700-937e-8d1edbfa024a" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/58a41eec-76f4-47e0-8e73-709c0b6b8f85" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/e2ce8471-cff8-42a0-b278-b175ef6f1609" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/beeb8f51-b535-4985-bb41-441bb4495982" width="180"/></td>
  </tr>
  <tr>
    <td align="center"><b>Home</b></td>
    <td align="center"><b>Search & Filter</b></td>
    <td align="center"><b>Hotel Details</b></td>
    <td align="center"><b></b></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/f34a32fe-ebcd-4ada-b0a8-b5031cb1ab01" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/3a375300-d0dd-442b-8c56-82aba432c8a5" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/4ec648ba-6944-4385-8536-69f679014649" width="180"/></td>
    <td></td>
  </tr>
  <tr>
    <td align="center"><b>Booking</b></td>
    <td align="center"><b>Payment</b></td>
    <td align="center"><b>Wallet</b></td>
    <td align="center"><b></b></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/d98ebec0-7435-48b6-b139-c2629d6675e8" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/65ab66bc-e0cc-47d0-918f-6d90b221e67c" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/5947cfaa-dc11-40c6-b145-8c364b4665f3" width="180"/></td>
    <td></td>
  </tr>
  <tr>
    <td align="center"><b>AI Assistant</b></td>
    <td align="center"><b>Profile</b></td>
    <td align="center"><b>Notifications</b></td>
    <td align="center"><b></b></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/1649e769-3c2b-4dbe-b569-774e4f3dccc9" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/96be6462-67b9-4eca-b41b-c71c401c3e22" width="180"/></td>
    <td><img src="https://github.com/user-attachments/assets/1f909b88-26c2-4f8f-9a5e-07660793ab13" width="180"/></td>
    <td></td>
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

The project follows **Clean Architecture** with a feature-based folder structure.

```text
lib/
├── core/
│   ├── constants/          # App constants (including api_constants.dart — gitignored)
│   ├── di/                 # Dependency Injection (GetIt)
│   ├── helpers/            # Shared helpers
│   ├── network/            # API & Supabase services
│   ├── router/             # GoRouter configuration
│   ├── theme/              # App themes & colors
│   ├── widgets/            # Reusable widgets
│   └── models/             # Shared models
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── logic/
│   │   └── ui/
│   │
│   ├── home/
│   ├── hotel_details/
│   ├── booking/
│   ├── payment/
│   ├── wallet/
│   ├── favorites/
│   ├── profile/
│   ├── notifications/
│   └── chat_ai/
│
├── hotel_app.dart
└── main.dart
```

---

## Tech Stack

| Area | Technology |
|------|-----------|
| Framework | Flutter 3.8+ |
| Language | Dart ^3.8.1 |
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

- Flutter SDK compatible with Dart `^3.8.1`
- A [Supabase](https://supabase.com) project
- A [Stripe](https://stripe.com) account

### Installation

```bash
git clone https://github.com/AbdElhamidShahin/Hotel-Guide.git
cd Hotel-Guide
git checkout development-
flutter pub get
flutter run
```

> **Note:** The default branch is `development-`. The `git checkout development-` step is only needed if your git client does not check it out automatically after clone.

### Environment Setup

`lib/core/constants/api_constants.dart` is excluded from version control (listed in `.gitignore`). You must create it locally before running the app:

```dart
// lib/core/constants/api_constants.dart
// This file is gitignored. Do not commit real credentials.
abstract class ApiConstants {
  static const String supabaseUrl = "YOUR_SUPABASE_URL";
  static const String supabaseKey = "YOUR_SUPABASE_ANON_KEY";
  static const String stripePublishableKey = "YOUR_STRIPE_PUBLISHABLE_KEY";
}
```

> The Supabase anon key is safe to use client-side provided your Row Level Security (RLS) policies are correctly configured. The Stripe publishable key is intentionally public-facing. Your Stripe secret key must remain server-side only (Edge Function) and must never appear in Flutter source code.

---

## Payment Flow
