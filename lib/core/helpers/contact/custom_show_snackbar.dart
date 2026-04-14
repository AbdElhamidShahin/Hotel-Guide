import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomSnackbar(
    BuildContext context,
    ContentType messageType,
    String title,
    String message,
    ) {
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50.h,
      left: 20.w,
      right: 20.w,
      child: Material(
        color: Colors.transparent,
        child: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: messageType,
          inMaterialBanner: true,
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}