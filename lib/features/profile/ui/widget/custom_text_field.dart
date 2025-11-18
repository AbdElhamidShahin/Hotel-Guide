import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.textBlack,
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
              color: AppColors.textBlack,
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.hintTextGrey,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.borderGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.borderGrey,
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