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
import '../../features/payment/data/payment_repo/payment_repo_impl.dart';
import '../../features/payment/data/repo.dart';
import '../../features/payment/logic/booking_cubit.dart';
import '../../features/payment/logic/card_cubit/payment_cubit.dart';
import '../../features/room/data/home_repo_impl.dart';
import '../../features/search/data/repo/search_repo.dart';
import '../../features/search/data/repo/search_repo_iplm.dart';
import '../../features/wallet/date/wallet_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // ── 1. الأساسيات (Core Services) ───────────────────────
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());

  // بنسجل الـ Client مرة واحدة بس في الأول
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // ── 2. الـ Repositories (تعتمد على الـ Client) ──────────
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

  getIt.registerLazySingleton<SearchRepo>(() => SearchRepoImpl());

  getIt.registerLazySingleton<BookingRepository>(
        () => BookingRepository(getIt<SupabaseClient>()), // تأكد إن الـ Constructor بياخد Client
  );

  getIt.registerLazySingleton<PaymentRepoImpl>(() => PaymentRepoImpl());

  // ── 3. الـ Cubits (تعتمد على الـ Repositories) ──────────
  getIt.registerFactory(() => LoginCubit(getIt<LoginRepository>()));
  getIt.registerFactory(() => SignUpCubit(getIt<SignUpRepository>()));
  getIt.registerFactory(() => HomeCubit(getIt<HomeRepository>()));
  getIt.registerFactory(() => RoomCubit(getIt<RoomRepo>()));
  getIt.registerFactory(() => SearchCubit(getIt<SearchRepo>()));
  getIt.registerFactory(() => BookingCubit(getIt<BookingRepository>()));
  getIt.registerFactory(() => PaymentCubit(getIt<PaymentRepoImpl>()));

  getIt.registerLazySingleton(() => FavoriteCubit());
  getIt.registerFactory(() => WalletCubit());
  getIt.registerLazySingleton(() => NotificationCubit());
}
