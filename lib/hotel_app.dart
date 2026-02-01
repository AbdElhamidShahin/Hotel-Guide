import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_guide/features/home/logic/cubit/home_cubit.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';

class HotelApp extends StatelessWidget {
  const HotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeCubit>()..getHotelsAndCities(),
        ),
      ],
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (context, _) => MaterialApp.router(
            routerConfig: AppRouter.router,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
