import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme_data.dart';
import 'core/theme/cubit/theme_cubit.dart';

class HotelApp extends StatelessWidget {
  const HotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      // Provide the single LazySingleton instance from GetIt to the widget tree.
      create: (_) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: MaterialApp.router(
                  routerConfig: AppRouter.router,
                  debugShowCheckedModeBanner: false,

                  // ── Theme wiring ────────────────────────────────────
                  theme: AppThemeData.dark,
                  darkTheme: AppThemeData.dark,
                  // ThemeCubit drives this — any toggleTheme() call
                  // rebuilds this BlocBuilder and the entire app switches.
                  themeMode: themeState.themeMode,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
