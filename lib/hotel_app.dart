import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/router/app_router.dart';
class HotelApp extends StatelessWidget {
  const HotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(      textDirection: TextDirection.rtl,

      child: ScreenUtilInit(
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
    );
  }
}
