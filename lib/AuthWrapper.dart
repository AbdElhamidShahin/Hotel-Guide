import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/router/routers.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  StreamSubscription<AuthState>? _authSub;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    final client = Supabase.instance.client;

    // ✅ Check existing session immediately (handles app restart while logged in)
    final existingSession = client.auth.currentSession;
    if (existingSession != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(routes.homeScreen);
      });
      return;
    }

    // ✅ Listen only to meaningful auth events — ignore INITIAL_SESSION with null
    _authSub = client.auth.onAuthStateChange.listen((data) {
      if (!mounted) return;

      final event = data.event;
      final session = data.session;

      debugPrint('🔐 Auth event: $event | session: ${session?.user.id}');

      switch (event) {
        case AuthChangeEvent.signedIn:
        // ✅ Navigate to home on confirmed sign-in
          context.go(routes.homeScreen);
          break;

        case AuthChangeEvent.signedOut:
        // ✅ Navigate to onboarding on sign-out
          context.go(routes.onBoardingScreen);
          break;

        case AuthChangeEvent.tokenRefreshed:
        // Token refreshed — stay where we are, no navigation needed
          break;

        default:
        // INITIAL_SESSION with null → go to onboarding
          if (session == null) {
            context.go(routes.onBoardingScreen);
          }
      }
    });
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}