// core/helpers/contact/custom_show_snackbar.dart

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

// ✅ يجب تعريف هذا النوع في ملف الـ SnackBar الأصلي لديك ليعمل
// enum ContentType { success, failure, help, warning }
// (نفترض أنه مُعرَّف في مكان آخر)

void showCustomSnackbar(BuildContext context, ContentType messageType,
    String title, String message) {
  // تحديد اللون والرمز بناءً على النوع
  Color backgroundColor;
  IconData icon;

  if (messageType == ContentType.success) {
    backgroundColor = Colors.green.shade700;
    icon = Icons.check_circle;
  } else if (messageType == ContentType.failure) {
    backgroundColor = Colors.red.shade700;
    icon = Icons.error;
  } else { // التعامل مع Warning و Help
    backgroundColor = Colors.orange.shade700;
    icon = Icons.warning;
  }

  final snackBar = SnackBar(
    // ✅ يجب استخدام AwesomeSnackbarContent
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: messageType,
    ),
    // ✅ ضبط سلوك الـ SnackBar
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}