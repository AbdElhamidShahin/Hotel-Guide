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
    _loadInitialData();
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
  String? profileImage;

  Future<void> _loadInitialData() async {
    final data = await UserDataManager.loadUserData();
    setState(() {
      _nameController.text = (widget.name.isNotEmpty) ? widget.name : (data['name'] ?? '');
      _emailController.text = data['email'] ?? '';
      _phoneController.text = data['phone'] ?? '';
      profileImage = data['image'];
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
                showEditIcon: true,
                showAddIcon: true,
                imageUrl: profileImage,
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
                hintText: 'القاهره',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال العنوان';
                  }
                  return null;
                },
              ),


              const SizedBox(height: 40),
              SizedBox(
                width: 260,
                height: 60,
                child: CustomButton(
                  color: AppColors.primary,
                  text: 'تحديث الملف الشخصي',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await UserDataManager.saveUserData(
                        name: _nameController.text,
                        image: _imageFile?.path ?? profileImage,
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