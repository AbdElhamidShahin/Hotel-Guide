import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/injection.dart';
import 'core/constants/api_constants.dart';
import 'hotel_app.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = ApiConstants.publishableKey;
  await Stripe.instance.applySettings();
  await ScreenUtil.ensureScreenSize();
  await setupGetIt();
  await Supabase.initialize(
    url: ApiConstants.supabaseUrl,
    anonKey: ApiConstants.supabaseAnonKey,
  );
  await initializeDateFormatting('ar_SA', null);
  runApp(HotelApp());
}
