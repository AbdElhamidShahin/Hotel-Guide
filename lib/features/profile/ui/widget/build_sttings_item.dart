import 'package:flutter/material.dart';

Widget buildSttingsItem({
  required String title,
  required IconData icon,
  required VoidCallback onTap,
  bool isLast = false,
}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.arrow_back_ios_new,
                size: 24,
                color: Colors.black,
              ),

              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Cairo',

                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(icon, color: Colors.black.withOpacity(0.7), size: 28),
                ],
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, color: Color(0xFFEEEEEE)),
      ],
    ),
  );
}