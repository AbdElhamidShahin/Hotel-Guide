import 'package:flutter/material.dart';
import 'dart:io';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_buttom.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_profile_image_and_name.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_text_field.dart';

import '../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../core/helpers/local_storage_account.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  File? _currentImageFile;

  void _updateImageFile(File? newFile) {
    setState(() {
      _currentImageFile = newFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomProfileImageAndName(
                showEditIcon: false,
                showAddIcon: true,
                currentImageFile: _currentImageFile,
                onImagePicked: _updateImageFile,
              ),
              const SizedBox(height: 12),

              Customtextfeild(
                controller: _nameController,
                label: 'إسم المستخدم',
                hintText: ' عبده شاهين',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

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
              const SizedBox(height: 8),

              Customtextfeild(
                controller: _addressController,
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
                        fontSize: 15,
                        color: AppColors.black,
                        fontFamily: 'Cairo',
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
                                hintStyle: TextStyle(
                                  color: AppColors.hintTextGrey,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال رقم الهاتف';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: AppColors.borderGrey,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: const [
                                Text("🇪🇬", style: TextStyle(fontSize: 24)),
                                SizedBox(width: 8),
                                Text(
                                  "+20",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 20,
                                ),
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
                width: 260,
                height: 60,
                child: CustomButton(
                  color: AppColors.mainOrange,
                  text: 'تعديل الملف',
                  onTap: () async {
                    // 1. التحقق من صحة حقول الإدخال
                    if (_formKey.currentState!.validate()) {
                      // 2. حفظ البيانات
                      await UserDataManager.saveUserData(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        email: _emailController.text,
                        imagePath: _currentImageFile?.path,
                      );

                      // 3. 🌟 استخدام maybePop كبديل أكثر أماناً
                      // تقوم هذه الدالة بمحاولة إغلاق الصفحة، وإذا لم تنجح (لأنها آخر صفحة)، فإنها تتوقف بدون إطلاق Error.
                      Navigator.maybePop(context, true);

                      // إذا كنت تفضل الانتقال لشاشة محددة بدلاً من العودة، استخدم:
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainProfileScreen()));
                    }
                  },
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
