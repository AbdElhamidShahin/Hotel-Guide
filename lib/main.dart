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
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://oavjmvbwyrkixfnlzmcg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hdmptdmJ3eXJraXhmbmx6bWNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4NzY4MDMsImV4cCI6MjA3ODQ1MjgwM30.AssSZLJLLC7X_DmkynMhkjy1Hrq--A82pol5YvE5wbs',
  );
  await initializeDateFormatting('ar_SA', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(HotelApp());
}
