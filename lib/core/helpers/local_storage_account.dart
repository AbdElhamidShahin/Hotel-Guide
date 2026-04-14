import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<void> saveUserLocally(String name, String email, String phone) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', name);
  await prefs.setString('email', email);
  await prefs.setString('phone', phone);
}

// بيتعامل مع التخزين
class UserDataManager {
  static Future<void> saveUserData({
    required String name,
    required String phone,
    required String email,
    String? image,
    String? address,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('phone', phone);
    await prefs.setString('email', email);

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
      'address': prefs.getString('address'),
    };
  }
}
//ui يتعامل مع ال
class UserDataNotifier extends ChangeNotifier {
  static final UserDataNotifier instance = UserDataNotifier._();
  UserDataNotifier._();

  String name = '';
  String email = '';
  String image = '';
  String phone = '';
  String address = '';

  Future<void> load() async {
    final data = await UserDataManager.loadUserData();
    name = data['name'] ?? '';
    email = data['email'] ?? '';
    image = data['image'] ?? '';
    phone = data['phone'] ?? '';
    address = data['address'] ?? '';
    notifyListeners();
  }

  Future<void> save({
    required String name,
    required String email,
    required String image,
    required String phone,
    required String address,
  }) async {
    await UserDataManager.saveUserData(
      name: name,
      email: email,
      image: image,
      phone: phone,
      address: address,
    );
    this.name = name;
    this.email = email;
    this.image = image;
    this.phone = phone;
    this.address = address;
    notifyListeners();
  }
}
