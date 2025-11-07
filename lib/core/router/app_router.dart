import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';

import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/on_boarding/ui/on_boarding_screen.dart';
import '../di/injection.dart';

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
      GoRoute(
        path: routes.loginScreen,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (BuildContext context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          );
        },
      ),

    ],
  );
}
