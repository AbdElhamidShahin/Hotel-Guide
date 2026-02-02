import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginRepostry {
  Future<AuthResponse> login(String email, String password);
}