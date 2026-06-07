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

  // ✅ Fix: Supabase must initialize BEFORE GetIt,
  // because GetIt registers Supabase.instance.client as a dependency.
  await Supabase.initialize(
    url: ApiConstants.supabaseUrl,
    anonKey: ApiConstants.supabaseAnonKey,
  );

  await setupGetIt();
  await initializeDateFormatting('ar_SA', null);
  runApp(const HotelApp());
}
