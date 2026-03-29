import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_guide/core/units/api_service.dart';
import 'package:hotel_guide/features/favorite/logic/cubit/favorite_cubit.dart';
import 'package:hotel_guide/features/home/data/repo/home_repo_impl.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import 'package:hotel_guide/features/login/data/repo/login_repoImpl.dart';
import 'package:hotel_guide/features/login/logic/cubit/login_cubit.dart';
import 'package:hotel_guide/features/notification/logic/notificatin_logic.dart';
import 'package:hotel_guide/features/payment/logic/card_cubit/payment_cubit.dart';
import 'package:hotel_guide/features/room/data/room_repo.dart';
import 'package:hotel_guide/features/room/logic/room_cubit.dart';
import 'package:hotel_guide/features/search/data/repo/search_repo_iplm.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_cubit.dart';
import 'package:hotel_guide/features/sign_up/data/repo/sign_up_repoImpl.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:hotel_guide/features/wallet/date/wallet_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/home/data/repo/home_repo.dart';
import '../../features/login/data/repo/login_repostry.dart';
import '../../features/payment/data/booking_repo/booking_repo.dart';
import '../../features/payment/data/booking_repo_impl.dart';
import '../../features/payment/data/payment_repo/payment_repo.dart';
import '../../features/payment/data/payment_repo/payment_repo_impl.dart';
import '../../features/payment/logic/booking_cubit.dart';
import '../../features/room/data/home_repo_impl.dart';
import '../../features/sign_up/data/repo/sign_up_repo.dart';
import '../network/service/SupabaseService.dart';
import '../units/stripe_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Core
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton<StripeService>(() => StripeService(getIt<ApiService>()));
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());

  // Repositories (interfaces)
  getIt.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<SignUpRepository>(
        () => SignUpRepoImpl(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepoImpl(getIt<SupabaseService>()),
  );
  getIt.registerLazySingleton<RoomRepo>(
        () => RoomRepoImpl(getIt<SupabaseService>()),
  );
  getIt.registerLazySingleton<SearchRepository>(
        () => SearchRepoImpl(),
  );
  getIt.registerLazySingleton<PaymentRepository>(
        () => PaymentRepositoryImpl(getIt<StripeService>()),
  );
  getIt.registerLazySingleton<BookingRepository>(
        () => BookingRepositoryImpl(getIt<SupabaseClient>()),
  );

  // Cubits (factories)
  getIt.registerFactory(() => LoginCubit(getIt<LoginRepository>()));
  getIt.registerFactory(() => SignUpCubit(getIt<SignUpRepository>()));
  getIt.registerFactory(() => HomeCubit(getIt<HomeRepository>()));
  getIt.registerFactory(() => RoomCubit(getIt<RoomRepo>()));
  getIt.registerFactory(() => SearchCubit(getIt<SearchRepository>()));
  getIt.registerFactory(() => BookingCubit(getIt<BookingRepository>()));
  getIt.registerFactory(() => PaymentCubit(getIt<PaymentRepository>()));
  getIt.registerFactory(() => FavoriteCubit());
  getIt.registerFactory(() => WalletCubit());
  getIt.registerFactory(() => NotificationCubit());
}