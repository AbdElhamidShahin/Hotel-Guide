import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';

import '../../features/home/ui/home_screen.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/on_boarding/ui/on_boarding_screen.dart';
import '../../features/sign_up/ui/sign_up_screen.dart';
import '../../features/verification/ui/verification_screen.dart';
import '../di/injection.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: routes.homeScreen,
    routes: [
      GoRoute(
        path: routes.onBoardingScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const OnBoardingScreen();
        },
      ),
      GoRoute(
        path: routes.loginScreen,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (BuildContext context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: routes.signUpScreen,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (BuildContext context) => getIt<SignUpCubit>(),
            child: SignUpScreen(),
          );
        },
      ),
      GoRoute(
        path: routes.homeScreen,
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: routes.verificationScreen,
        builder: (BuildContext context, GoRouterState state) {
          final email = state.extra as String? ?? '';
          return VerificationScreen(email: email);
        },
      ),
    ],
  );
}
