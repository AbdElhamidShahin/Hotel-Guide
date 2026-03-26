import 'package:get_it/get_it.dart';
import 'package:hotel_guide/core/network/service/SupabaseService.dart';
import 'package:hotel_guide/features/login/data/repo/login_repoImpl.dart';
import 'package:hotel_guide/features/login/logic/cubit/login_cubit.dart';
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
import '../../features/login/data/repo/login_repostry.dart';
import '../../features/notification/logic/notificatin_logic.dart';
import '../../features/payment/data/repo.dart';
import '../../features/payment/logic/booking_cubit.dart';
import '../../features/room/data/home_repo_impl.dart';
import '../../features/search/data/repo/search_repo.dart';
import '../../features/search/data/repo/search_repo_iplm.dart';
import '../../features/wallet/date/wallet_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // ── Services ─────────────────────────────────
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // ── Login ✅ ──────────────────────────────────
  getIt.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(getIt<SupabaseClient>()),
  );
  getIt.registerFactory<LoginCubit>(
        () => LoginCubit(getIt<LoginRepository>()),
  );

  // ── Sign Up ✅ ────────────────────────────────
  getIt.registerLazySingleton<SignUpRepository>(
        () => SignUpRepoImpl(getIt<SupabaseClient>()),
  );
  getIt.registerFactory<SignUpCubit>(
        () => SignUpCubit(getIt<SignUpRepository>()),
  );

  // ── Home ─────────────────────────────────────
  getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepoImpl(getIt<SupabaseService>()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));

  // ── Rooms ─────────────────────────────────────
  getIt.registerLazySingleton<RoomRepo>(
        () => RoomRepoImpl(getIt<SupabaseService>()),
  );
  getIt.registerFactory<RoomCubit>(() => RoomCubit(getIt<RoomRepo>()));

  // ── Search ────────────────────────────────────
  getIt.registerLazySingleton<SearchRepo>(() => SearchRepoImpl());
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt<SearchRepo>()));

  // ── Payment & Booking ─────────────────────────
  getIt.registerLazySingleton<BookingRepository>(
        () => BookingRepository(getIt()),
  );
  getIt.registerFactory<BookingCubit>(
        () => BookingCubit(getIt<BookingRepository>()),
  );

  // ── Others ────────────────────────────────────
  getIt.registerLazySingleton<FavoriteCubit>(() => FavoriteCubit());
  getIt.registerFactory<WalletCubit>(() => WalletCubit());
  getIt.registerLazySingleton<NotificationCubit>(() => NotificationCubit());
}
