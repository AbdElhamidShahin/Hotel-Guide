import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/logic/cubit/home_cubit.dart';
import '../../features/login/data/repo/login_repoImpl.dart';
import '../../features/login/data/repo/login_repostry.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/notification/logic/notificatin_logic.dart';
import '../../features/payment/data/repo/booking_repo.dart';
import '../../features/payment/data/repo/booking_repo_impe.dart';
import '../../features/payment/data/repo/payment_repo_impl.dart';
import '../../features/payment/data/repo/payment_repository.dart';
import '../../features/payment/logic/booking_cubit.dart';
import '../../features/room/data/home_repo_impl.dart';
import '../../features/room/data/room_repo.dart';
import '../../features/room/logic/room_cubit.dart';
import '../../features/search/data/repo/search_repo.dart';
import '../../features/search/data/repo/search_repo_iplm.dart';
import '../../features/search/logic/cubit/search_cubit.dart';
import '../../features/sign_up/data/repo/sign_up_repo.dart';
import '../../features/sign_up/data/repo/sign_up_repoImpl.dart';
import '../../features/sign_up/logic/cubit/sign_up_cubit.dart';
import '../../features/favorite/logic/cubit/favorite_cubit.dart';
import '../../features/wallet/data/wallet_repo.dart';
import '../../features/wallet/data/wallet_repo_imple.dart';
import '../../features/wallet/logic/wallet_cubit.dart';
import '../network/service/SupabaseService.dart';
import '../theme/cubit/theme_cubit.dart';
import '../units/api_service.dart';
import '../units/stripe_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  if (getIt.isRegistered<SupabaseClient>()) return;


  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<StripeService>(() => StripeService());

 getIt.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(ThemeMode.light), // placeholder; real value set in main()
  );

  // ── Auth ───────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getIt<SupabaseClient>()),
  );
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepository>()));

  getIt.registerLazySingleton<SignUpRepository>(
    () => SignUpRepoImpl(getIt<SupabaseClient>()),
  );
  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(getIt<SignUpRepository>()),
  );

  // ── Home ───────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepoImpl(getIt<SupabaseService>()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));

  // ── Rooms ──────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<RoomRepo>(
    () => RoomRepoImpl(getIt<SupabaseService>()),
  );
  getIt.registerFactory<RoomCubit>(() => RoomCubit(getIt<RoomRepo>()));

  // ── Search ─────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<SearchRepo>(
    () => SearchRepoImpl(getIt<SupabaseClient>()),
  );
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt<SearchRepo>()));

  // ── Payment ────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepoImpl(getIt<StripeService>()),
  );
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepoImpl(getIt<SupabaseClient>()),
  );
  getIt.registerFactory<BookingCubit>(
    () => BookingCubit(
      paymentRepository: getIt<PaymentRepository>(),
      bookingRepository: getIt<BookingRepository>(),
    ),
  );

  // ── Wallet ─────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(getIt<SupabaseClient>()),
  );
 getIt.registerFactory<WalletCubit>(
    () => WalletCubit(
      repo: getIt<WalletRepository>(),
      stripe: getIt<StripeService>(),
    ),
  );

  // ── Others ─────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<FavoriteCubit>(() => FavoriteCubit());
 getIt.registerFactory<NotificationCubit>(
    () => NotificationCubit(getIt<SupabaseClient>()),
  );
}
