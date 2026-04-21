
import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/colors.dart';

Padding CustomItemSetteings(String text, final VoidCallback? onPressed) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.warning),
              ),
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  color: AppColors.warning, borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Divider(
            color: Colors.black12,
          ),
        ),
      ],
    ),
  );
}
