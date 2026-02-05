import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/router/app_router.dart';
import 'core/router/routers.dart' show routes;
import 'features/home/ui/home_screen.dart';
import 'features/on_boarding/ui/on_boarding_screen.dart';
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدم Supabase للتحقق من الجلسة الحالية
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      // المستخدم مسجل دخول -> ودديه للهوم
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(routes.homeScreen);
      });
      return const SizedBox.shrink();
    } else {
      // المستخدم جديد أو مسح الداتا -> ودديه للـ OnBoarding
      return const OnBoardingScreen();
    }
  }
}