import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'core/router/app_router.dart';
import 'core/router/routers.dart' show routes;
import 'features/home/ui/home_screen.dart';
import 'features/on_boarding/ui/on_boarding_screen.dart';
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).go(routes.homeScreen); // مسار الـ route
      });
      return const SizedBox.shrink();
    } else {
      return const OnBoardingScreen();
    }

  }
}
