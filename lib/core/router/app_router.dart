import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/favorite/ui/favorite_screen.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_cubit.dart';
import 'package:hotel_guide/features/search/ui/search_screen.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';
import '../../AuthWrapper.dart';
import '../../features/favorite/logic/cubit/favorite_cubit.dart';
import '../../features/home/ui/custom_details_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/on_boarding/ui/on_boarding_screen.dart';
import '../../features/profile/ui/edit_account_screen.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../../features/sign_up/ui/sign_up_screen.dart';

import '../../main_app_shell.dart';
import '../di/injection.dart';
import '../network/hotel_model.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: routes.authWrapper,
    routes: [
      GoRoute(
        path: routes.authWrapper,
        builder: (BuildContext context, GoRouterState state) => BlocProvider(
          create: (context) => getIt<HomeCubit>(),

          child: const AuthWrapper(),
        ),
      ),
      GoRoute(
        path: routes.onBoardingScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const OnBoardingScreen(),
      ),
      GoRoute(
        path: routes.loginScreen,
        builder: (BuildContext context, GoRouterState state) => BlocProvider(
          create: (BuildContext context) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: routes.signUpScreen,
        builder: (BuildContext context, GoRouterState state) => BlocProvider(
          create: (BuildContext context) => getIt<SignUpCubit>(),
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        path: routes.customDetailsScreen,
        builder: (BuildContext context, GoRouterState state) {
          return CustomDetailsScreen(hotelModel: state.extra as HotelModel);
        },
      ),
      GoRoute(
        path: routes.searchScreen,
        builder: (BuildContext context, GoRouterState state) => BlocProvider(
          create: (BuildContext context) => getIt<SearchCubit>(),
          child: const SearchView(),
        ),
      ),
      // في AppRouter
      GoRoute(
        path: routes.editAccountScreen,
        builder: (BuildContext context, GoRouterState state) {
          final data = state.extra as Map<String, dynamic>?;
          return EditAccountScreen(name: data?['name'] ?? '');
        },
      ),


      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainAppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: routes.accountScreen,
                builder: (context, state) {
                  final data = state.extra as Map<String, dynamic>?;

                  return BlocProvider(
                    create: (context) => getIt<HomeCubit>(),
                    child: AccountScreen(name: data?["name"] ?? ""),
                  );
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/notifications',
                builder: (context, state) =>
                    const Center(child: Text('Notifications Screen (Index 1)')),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: routes.favoritesScreen,
                builder: (context, state) => BlocProvider(
                  create: (context) => getIt<FavoriteCubit>(),
                  child: const FavoriteScreen(),
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: routes.homeScreen,
                builder: (context, state) {
                  // استلام البيانات من extra
                  final data = state.extra as Map<String, dynamic>?;

                  return BlocProvider(
                    create: (context) => getIt<HomeCubit>(),
                    child: HomeScreen(name: data?["name"] ?? ""),
                  );
                },
              ),
            ],
          ),
        ],
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // يستخدم MainAppShell الجديد الذي يدعم 4 فروع
          return MainAppShell(navigationShell: navigationShell);
        },
        branches: [
          // Index 0: Profile Screen (الشكل الأول)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: routes.accountScreen,
                builder: (context, state) {
                  // استلام البيانات من extra
                  final data = state.extra as Map<String, dynamic>?;

                  return BlocProvider(
                    create: (context) => getIt<HomeCubit>(),
                    child: AccountScreen(name: data?["name"] ?? ""),
                  );
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/notifications',
                builder: (context, state) =>
                    const Center(child: Text('Notifications Screen (Index 1)')),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: routes.favoritesScreen,
                builder: (context, state) =>
                    const Center(child: Text('Favorites Screen (Index 2)')),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: routes.homeScreen,
                builder: (context, state) {
                  // استلام البيانات من extra
                  final data = state.extra as Map<String, dynamic>?;

                  return BlocProvider(
                    create: (context) => getIt<HomeCubit>(),
                    child: HomeScreen(name: data?["name"] ?? ""),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
