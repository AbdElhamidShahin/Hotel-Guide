import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_guide/features/login/data/repo/login_repostry.dart';
import 'package:hotel_guide/features/sign_up/data/repo/sign_up_repo.dart';
import 'package:hotel_guide/features/sign_up/data/repo/sign_up_repoImpl.dart';
import 'package:hotel_guide/features/sign_up/logic/cubit/sign_up_cubit.dart';
import '../../features/login/data/repo/login_repoImpl.dart';
import '../../features/login/logic/cubit/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  /// fire base
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  ///login
  getIt.registerLazySingleton<LoginRepostry>(
    () => AuthRepositoryImpl(getIt<FirebaseAuth>()),
  );
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepostry>()));

  ///signup
  getIt.registerLazySingleton<SignUpRepostry>(
    () => SignUpRepoimpl(getIt<FirebaseAuth>()),
  );
  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(getIt<SignUpRepostry>()),
  );
}
