import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_buttom.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_profile_image_and_name.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_text_field.dart';


class EditAccountScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomProfileImageAndName(showEditIcon: false, showAddIcon: true),
              SizedBox(height: 28),

              Customtextfeild(
                controller: _nameController,
                label: 'إسم المستخدم',
                hintText: 'شادي عبده',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              Customtextfeild(
                controller: _emailController,
                label: 'البريد الإلكتروني',
                hintText: 'example@gmail.com',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الايميل';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              Customtextfeild(
                label: 'العنوان',
                hintText: 'العجيزي - مساكن الشباب',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال العنوان';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'رقم الهاتف',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderGrey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: "XXXX-XXX-XXXX",
                                hintStyle: TextStyle(color: AppColors.hintTextGrey, fontSize: 16),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال رقم الهاتف';
                                }
                                return null;
                              },
                            ),
                          ),

                          // الفاصل
                          Container(
                            height: 30,
                            width: 1,
                            color: AppColors.borderGrey,
                          ),

                          // العلم والكود
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: const [
                                Text("🇪🇬", style: TextStyle(fontSize: 24)), // علم مصر
                                SizedBox(width: 8),
                                Text("+20", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: CustomButton(
                  color: AppColors.mainOrange,
                  text: 'تعديل الملف', // أصبح النص أسود الآن
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
