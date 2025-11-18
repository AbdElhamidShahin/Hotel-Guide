import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';


class Customtextfeild extends StatelessWidget {
  Customtextfeild({
    super.key,
    required this.hintText,
    required this.label,
    this.onChanged,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style:  TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.black,
              fontFamily: 'Cairo',

            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            keyboardType: keyboardType,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              hintStyle: textStyle15MediumGray,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.yellowGold),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:  BorderSide(
                  color: AppColors.black4.withOpacity(0.7),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.mainOrange,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}