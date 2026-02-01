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
import '../../features/favorite/logic/cubit/favorite_cubit.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/logic/cubit/home_cubit.dart';
import '../../features/login/data/repo/login_repoImpl.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/room/data/home_repo_impl.dart';
import '../../features/search/data/repo/search_repo.dart';
import '../../features/search/data/repo/search_repo_iplm.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  /// Firebase & Services
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());

  /// Login
  getIt.registerLazySingleton<LoginRepostry>(
    () => AuthRepositoryImpl(getIt<FirebaseAuth>()),
  );
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepostry>()));

  /// Signup
  getIt.registerLazySingleton<SignUpRepostry>(
    () => SignUpRepoimpl(getIt<FirebaseAuth>()),
  );
  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(getIt<SignUpRepostry>()),
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
}
