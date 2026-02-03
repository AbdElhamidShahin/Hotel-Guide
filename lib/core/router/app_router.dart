import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/helpers/widget/custom_item.dart';
import 'package:hotel_guide/core/network/city_model.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/favorite/ui/favorite_screen.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import 'package:hotel_guide/features/home/ui/menu_screen.dart';
import 'package:hotel_guide/features/room/logic/room_cubit.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_cubit.dart';
import 'package:hotel_guide/features/search/ui/search_screen.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';
import '../../AuthWrapper.dart';
import '../../features/favorite/logic/cubit/favorite_cubit.dart';
import '../../features/home/ui/custom_details_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/home/ui/widget/home/city_hotels_screen.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/notification/ui/notification_screen.dart';
import '../../features/on_boarding/ui/on_boarding_screen.dart';
import '../../features/payment/logic/booking_cubit.dart';
import '../../features/payment/ui/booking_details_page.dart';
import '../../features/profile/ui/edit_account_screen.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../../features/room/ui/custom_room.dart';
import '../../features/room/ui/rooms_screen_list-view.dart';
import '../../features/room/ui/widget/room_details_page.dart';
import '../../features/sign_up/ui/sign_up_screen.dart';

import '../../features/wallet/date/wallet_cubit.dart';
import '../../features/wallet/ui/wallet_screen.dart';
import '../../main_app_shell.dart';
import '../di/injection.dart';
import '../network/hotel_bloc.dart';
import '../network/hotel_model.dart';
import '../network/model/city.dart';
import '../network/model/hotel.dart';
import '../network/model/room.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: routes.homeScreen,
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
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<FavoriteCubit>()),
              BlocProvider(create: (context) => getIt<HomeCubit>()),
              BlocProvider(create: (context) => getIt<RoomCubit>()),
            ],
            child: CustomDetailsScreen(hotelModel: state.extra as HotelModel),
          );
        },
      ),
      GoRoute(
        path: routes.cityHotelsScreen,
        builder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>;

          final city = extraData['city'] as CityModel;
          final hotels = extraData['hotels'] as List<HotelModel>;

          return BlocProvider.value(
            value: getIt<FavoriteCubit>(),
            child: CityHotelsScreen(city: city, hotels: hotels),
          );
        },
      ),
      GoRoute(
        path: routes.customItem,
        builder: (BuildContext context, GoRouterState state) {
          return CustomItem(
            hotelModel: state.extra as HotelModel,
            isContinar: false,
          );
        },
      ),
      GoRoute(
        path: routes.searchScreen,
        builder: (BuildContext context, GoRouterState state) =>
            MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<FavoriteCubit>()),
                BlocProvider<SearchCubit>(
                  create: (_) => getIt<SearchCubit>()..loadHotels(),
                ),
              ],
              child: const SearchScreen(),
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

      GoRoute(
        path: routes.CustomRoom,
        builder: (BuildContext context, GoRouterState state) {
          final room = state.extra as Room;

          return BlocProvider(
            create: (context) => getIt<RoomCubit>(),
            child: CustomRoom(room: room),
          );
        },
      ),
      GoRoute(
        path: routes.RoomDetailsPage,
        builder: (context, state) {
          final room = state.extra as Room;
          return RoomDetailsPage(room: room);
        },
      ),
      // في ملف app_router.dart
      // في ملف app_router.dart
      GoRoute(
        path: routes.BookingDetailsPage,
        builder: (context, state) {
          final room = state.extra as Room; // استخراج الغرفة من الـ extra
          return BlocProvider(
            create: (context) => getIt<BookingCubit>(),
            child: BookingDetailsPage(room: room), // تمريرها للشاشة
          );
        },
      ),

      GoRoute(
        path: routes.notification,
        builder: (BuildContext context, GoRouterState state) {
          return NotificationScreenListView();
        },
      ),
      GoRoute(
        path: routes.WalletScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<WalletCubit>(),
          child: WalletScreen(),
        ),
      ),
      GoRoute(
        path: routes.RoomsScreenListView,
        builder: (context, state) {
          final String hotelId = (state.extra as String?) ?? "";

          return BlocProvider.value(
            value: getIt<RoomCubit>(),
            child: RoomsScreenListView(hotelId: hotelId),
          );
        },
      ),
      // GoRoute(
      //   path: routes.ShowCitysListVeiw,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return ShowCitysListVeiw(count: null,);
      //   },
      // ),
      GoRoute(
        path: routes.menuScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const MenuScreen(),
            transitionDuration: const Duration(milliseconds: 1000),
            reverseTransitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final curvedAnimation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                    reverseCurve: Curves.easeInBack,
                  );
                  final slide = Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(curvedAnimation);

                  final scale = Tween<double>(
                    begin: 0.88,
                    end: 1.0,
                  ).animate(curvedAnimation);
                  final opacity = Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(curvedAnimation);

                  return FadeTransition(
                    opacity: opacity,
                    child: ScaleTransition(
                      scale: scale,
                      alignment: Alignment.centerLeft,
                      child: SlideTransition(position: slide, child: child),
                    ),
                  );
                },
          );
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
                path: routes.WalletScreen,
                builder: (context, state) => WalletScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: routes.favoritesScreen,
                builder: (context, state) => BlocProvider.value(
                  value: getIt<FavoriteCubit>(),
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

                  return BlocProvider(
                    create: (context) =>
                        getIt<HomeCubit>()..getHotelsAndCities(),
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
                path: routes.WalletScreen,
                builder: (context, state) => WalletScreen(),
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
                  final data = state.extra as Map<String, dynamic>?;

                  return BlocProvider(
                    create: (context) =>
                        getIt<HomeCubit>()..getHotelsAndCities(),
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
