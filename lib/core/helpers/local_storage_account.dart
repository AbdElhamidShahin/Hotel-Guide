import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserLocally(String name, String email, String phone) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', name);
  await prefs.setString('email', email);
  await prefs.setString('phone', phone);
}

class UserDataManager {
  static Future<void> saveUserData({
    required String name,
    required String phone,
    required String email,
    String? image, // غيرنا الاسم هنا ليكون عاماً
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('phone', phone);
    await prefs.setString('email', email);
    if (image != null) {
      await prefs.setString('image', image); // تخزين الرابط أو المسار
    }
  }

  static Future<Map<String, String?>> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name'),
      'phone': prefs.getString('phone'),
      'email': prefs.getString('email'),
      'image': prefs.getString('image'), // استرجاع القيمة
    };
  }
}