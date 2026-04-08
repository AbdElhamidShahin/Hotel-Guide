import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      // السطر الناقص اللي كان بيخلي العنوان يظهر فاضي:
      _addressController.text = data['address'] ?? '';
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
              SizedBox(height: 12.h),

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
              SizedBox(height: 8.h),

              Customtextfeild(
                controller: _emailController,
                label: 'البريد الإلكتروني',
                hintText: 'example@gmail.com',
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
               SizedBox(height: 8.h),

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


               SizedBox(height: 40.h),
              SizedBox(
                width: 0.85.sw,
                height: 55.h,
                child: CustomButton(
                  color: AppColors.primary,
                  text: 'تحديث الملف الشخصي',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // تأكد إن دالة saveUserData عندك بتقبل address
                      await UserDataManager.saveUserData(
                        name: _nameController.text,
                        image: _imageFile?.path ?? profileImage ?? "",
                        phone: _phoneController.text,
                        email: _emailController.text,
                        address: _addressController.text, // ضيف العنوان هنا عشان يتحفظ
                      );

                      Snackly.success(
                        context: context,
                        title: 'تم حفظ البيانات بنجاح',
                        style: SnackbarStyle.filled,
                      );

                      // بدل context.push استخدم context.go عشان تتجنب الشاشة البيضاء
                      // وتحدث حالة التطبيق بالكامل بالاسم الجديد
                      context.go(routes.homeScreen, extra: {'name': _nameController.text});
                    }
                  },
                ),
              ),
               SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}