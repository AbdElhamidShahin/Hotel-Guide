import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_guide/core/network/SupabaseService.dart';
import 'package:hotel_guide/features/login/data/repo/login_repostry.dart';
import 'package:hotel_guide/features/room/data/room_repo.dart';
import 'package:hotel_guide/features/room/logic/room_cubit.dart';
import 'package:hotel_guide/features/search/logic/cubit/search_cubit.dart';
import 'package:hotel_guide/features/sign_up/data/repo/sign_up_repo.dart';
import 'package:hotel_guide/features/sign_up/data/repo/sign_up_repoImpl.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/favorite/logic/cubit/favorite_cubit.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/logic/cubit/home_cubit.dart';
import '../../features/login/data/repo/login_repoImpl.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/payment/data/repo.dart';
import '../../features/payment/logic/booking_cubit.dart';
import '../../features/room/data/home_repo_impl.dart';
import '../../features/search/data/repo/search_repo.dart';
import '../../features/search/data/repo/search_repo_iplm.dart';
import '../../features/wallet/date/wallet_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  /// Firebase & Services
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());

  /// Login
  // مثال للتعديل في ملف الـ DI
  getIt.registerLazySingleton<LoginRepostry>(
    () => AuthRepositoryImpl(Supabase.instance.client),
  );
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepostry>()));

  /// Signup
  getIt.registerLazySingleton<SignUpRepository>(
        () => SignUpRepoImpl(),
  );

  getIt.registerFactory<SignUpCubit>(
        () => SignUpCubit(getIt<SignUpRepository>()),
  );

  /// Home & Hotel
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepoImpl(getIt<SupabaseService>()),
  );

  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));

  ///rooms

  getIt.registerLazySingleton<RoomRepo>(
    () => RoomRepoImpl(getIt<SupabaseService>()),
  );

  getIt.registerFactory<RoomCubit>(() => RoomCubit(getIt<RoomRepo>()));

  /// Favorite
  getIt.registerLazySingleton<FavoriteCubit>(() => FavoriteCubit());

  /// Search
  getIt.registerFactory<SearchRepo>(
    () => SearchRepoIplm(getIt<SupabaseService>()),
  );
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt<SearchRepo>()));

  getIt.registerFactory<WalletCubit>(() => WalletCubit());
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepository(getIt()),
  );

  getIt.registerFactory(() => BookingCubit(getIt()));
  getIt.registerFactory(() => BookingCubit(getIt<BookingRepository>()));
}
