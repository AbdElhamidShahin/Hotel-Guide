import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_guide/features/login/data/repo/login_repostry.dart';
import '../../features/login/data/repo/login_repoImpl.dart';
import '../../features/login/logic/cubit/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<LoginRepostry>(
    () => AuthRepositoryImpl(getIt<FirebaseAuth>()),
  );

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepostry>()));
}
