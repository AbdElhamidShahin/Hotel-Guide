import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_buttom.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_profile_image_and_name.dart';
import 'package:hotel_guide/features/profile/ui/widget/custom_text_field.dart';
import 'package:snackly/snackly.dart';
import '../../../core/helpers/local_storage_account.dart';

class EditAccountScreen extends StatefulWidget {
  final String name;

  const EditAccountScreen({super.key, required this.name});

  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  File? _imageFile;
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name ?? '';
    _loadIfEmpty();
  }

  Future<void> _loadIfEmpty() async {
    if ((_nameController.text).isEmpty) {
      final data = await UserDataManager.loadUserData();
      _nameController.text = data['name'] ?? '';
      setState(() {});
    }
  }
  void _onImagePicked(File? file) {
    setState(() {
      _imageFile = file;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال الايميل';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) return 'أدخل عنوان بريد إلكتروني صالح';
    return null;
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
                currentImageFile: _imageFile,
                onImagePicked: _onImagePicked,
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
                validator: _validateEmail,
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
                    if (_formKey.currentState!.validate()) {
                      await UserDataManager.saveUserData(
                        name: _nameController.text,
                        imagePath: _imageFile?.path,
                        phone: _phoneController.text,
                        email: _emailController.text,
                      );
                      Snackly.success(
                        context: context,
                        title: 'تم حفظ البيانات بنجاح',
                        style: SnackbarStyle.filled,
                      );

                      context.go(routes.homeScreen, extra: {'name': _nameController.text});
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
