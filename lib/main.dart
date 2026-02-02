import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/injection.dart';
import 'firebase_options.dart';
import 'hotel_app.dart';
import 'package:intl/date_symbol_data_local.dart';
void main() async {
  setupGetIt();
  await ScreenUtil.ensureScreenSize();WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(

    url: 'https://oavjmvbwyrkixfnlzmcg.supabase.co',
    anonKey:
        '***REMOVED***',
  );
  await initializeDateFormatting('ar_SA', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(HotelApp());
}
