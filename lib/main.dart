import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/injection.dart';
import 'hotel_app.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  setupGetIt();

  await Supabase.initialize(
    url: 'https://oavjmvbwyrkixfnlzmcg.supabase.co',
    anonKey:
        '***REMOVED***',
  );
  await initializeDateFormatting('ar_SA', null);
  runApp(HotelApp());
}
