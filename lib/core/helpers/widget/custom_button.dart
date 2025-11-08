
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.onTap,
    required this.color,
    required this.color2,
  });

  final String? text;
  final VoidCallback? onTap;
  final Color color;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: color2),
          ),
          minimumSize: const Size(double.infinity, 55),
          padding: EdgeInsets.zero,
        ),
        onPressed: onTap,
        child: Text(
          text ?? '',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}