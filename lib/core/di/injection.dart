import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/logic/cubit/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  ///login
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<FirebaseAuth>()));

  ///SignUp
  // getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt<FirebaseAuth>()));




}
