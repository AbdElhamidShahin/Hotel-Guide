import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/favorite/ui/favorite_screen.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_cubit.dart';
import 'package:hotel_guide/features/search/ui/search_screen.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';
import '../../AuthWrapper.dart';
import '../../features/favorite/logic/cubit/favorite_cubit.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/logic/cubit/home_cubit.dart';
import '../../features/home/ui/custom_details_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/notification/ui/notification_screen.dart';
import '../../features/on_boarding/ui/on_boarding_screen.dart';
import '../../features/profile/ui/edit_account_screen.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../../features/sign_up/ui/sign_up_screen.dart';
import '../../main_app_shell.dart';
import '../di/injection.dart';
import '../helpers/widget/custom_item.dart';
import '../network/city_model.dart';
import '../network/hotel_model.dart';
import '../network/supabase_service.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: routes.authWrapper,
    routes: [
      GoRoute(
        path: routes.authWrapper,
        builder: (BuildContext context, GoRouterState state) =>
            MultiBlocProvider(
              providers: [
                BlocProvider<CitiesCubit>(
                  create: (context) =>
                      CitiesCubit(HomeRepoImpl(SupabaseService()))
                        ..fetchCities(),
                ),
                BlocProvider<HotelsCubit>(
                  create: (context) =>
                      HotelsCubit(HomeRepoImpl(SupabaseService())),
                ),
              ],
              child: AuthWrapper(),
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
        path: routes.customItem,
        builder: (BuildContext context, GoRouterState state) {
          final hotelModel = state.extra as HotelModel?;

          if (hotelModel == null) {
            // Handle null case - redirect or show error
            return const Scaffold(
              body: Center(child: Text('Hotel data not available')),
            );
          }

          return MultiBlocProvider(
            providers: [
              BlocProvider<CitiesCubit>(
                create: (context) =>
                    CitiesCubit(HomeRepoImpl(SupabaseService()))..fetchCities(),
              ),
              BlocProvider<HotelsCubit>(
                create: (context) =>
                    HotelsCubit(HomeRepoImpl(SupabaseService())),
              ),
            ],
            child: CustomItem(hotelModel: hotelModel, isContinar: false),
          );
        },
      ),
      GoRoute(
        path: routes.customItem,
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<CitiesCubit>(
                create: (context) =>
                    CitiesCubit(HomeRepoImpl(SupabaseService()))..fetchCities(),
              ),
              BlocProvider<HotelsCubit>(
                create: (context) =>
                    HotelsCubit(HomeRepoImpl(SupabaseService())),
              ),
            ],
            child: CustomItem(
              cityId: state.extra as int,
              isContinar: false,
              hotelModel: state.extra as HotelModel,
            ),
          );
        },
      ),
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
                  return AccountScreen(name: data?["name"] ?? "");
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: routes.notification,
                builder: (context, state) => NotificationScreenListView(),
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
                  final data = state.extra as Map<String, dynamic>?;

                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<CitiesCubit>(
                        create: (context) =>
                            CitiesCubit(HomeRepoImpl(SupabaseService()))
                              ..fetchCities(),
                      ),
                      BlocProvider<HotelsCubit>(
                        create: (context) =>
                            HotelsCubit(HomeRepoImpl(SupabaseService())),
                      ),
                    ],
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
