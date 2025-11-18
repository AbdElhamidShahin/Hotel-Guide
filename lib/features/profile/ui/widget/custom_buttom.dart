import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.onTap,
    required this.color, // نستخدم هذه لـ backgroundColor
    this.textColor = Colors.black, // النص أسود كما في الصورة
  });

  final String? text;
  final VoidCallback? onTap;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // لون الخلفية البرتقالي
          elevation: 0, // بدون ظل
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // حواف مستديرة جداً
            side: BorderSide(color: color), // الحدود بنفس لون الخلفية
          ),
          minimumSize: const Size(double.infinity, 55), // ليكون الزر عريضاً
        ),
        onPressed: onTap,
        child: Text(
          text ?? '',
          style: TextStyle(
            color: textColor, // لون النص أسود
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}