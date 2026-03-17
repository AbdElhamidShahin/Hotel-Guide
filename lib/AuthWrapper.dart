import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/router/routers.dart';
import 'features/on_boarding/ui/on_boarding_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(routes.homeScreen);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return const OnBoardingScreen();
    }
  }
}
