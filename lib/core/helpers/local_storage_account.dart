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
    String? image,
    String? address, // 1. أضفنا العنوان هنا
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('phone', phone);
    await prefs.setString('email', email);

    // 2. حفظ العنوان في الـ SharedPreferences
    if (address != null) {
      await prefs.setString('address', address);
    }

    if (image != null && image.isNotEmpty) {
      await prefs.setString('image', image);
    }
  }

  static Future<Map<String, String?>> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name'),
      'phone': prefs.getString('phone'),
      'email': prefs.getString('email'),
      'image': prefs.getString('image'),
      'address': prefs.getString('address'), // 3. استرجاع العنوان
    };
  }
}