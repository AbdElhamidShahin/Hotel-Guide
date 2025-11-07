import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';

import '../../features/on_boarding/ui/on_boarding_screen.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: routes.onBoardingScreen,
    routes: [
      GoRoute(
        path: routes.onBoardingScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const OnBoardingScreen();
        },
      ),
    ],
  );
}
