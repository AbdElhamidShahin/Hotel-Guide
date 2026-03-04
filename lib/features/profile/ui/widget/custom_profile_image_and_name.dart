import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/helpers/custom_user_avatar.dart';
import '../../../../core/helpers/local_storage_account.dart';

typedef ImagePickedCallback = void Function(File? file);

class CustomProfileImageAndName extends StatefulWidget {
  const CustomProfileImageAndName({
    super.key,
    this.showEditIcon = false,
    this.showAddIcon = false,
    this.onTap,
    this.currentImageFile,
    this.onImagePicked,
    this.name,
    this.imageUrl,
  });

  final bool showEditIcon;
  final bool showAddIcon;
  final VoidCallback? onTap;
  final File? currentImageFile;
  final ImagePickedCallback? onImagePicked;
  final String? name;
  final String? imageUrl;
  @override
  State<CustomProfileImageAndName> createState() =>
      _CustomProfileImageAndNameState();
}

class _CustomProfileImageAndNameState extends State<CustomProfileImageAndName> {
  String? image;
  String? name;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final userData = await UserDataManager.loadUserData();
    if (mounted) {
      setState(() {
        name = userData['name'] ?? widget.name;
        image = userData['image'] ?? widget.imageUrl;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        widget.onImagePicked?.call(file);
      }
    } catch (e) {
      debugPrint("حدث خطأ أثناء اختيار الصورة: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 40.h,
        bottom: 20.h,
        left: 20.w,
        right: 20.w,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF010101), Color(0xFF2C2C2C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.showEditIcon)
                IconButton(
                  onPressed: () => context.push(
                    routes.editAccountScreen,
                    extra: {'name': name ?? widget.name ?? ''},
                  ),
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.white.withOpacity(0.7),
                    size: 28.r,
                  ), // .r للـ icons
                )
              else
                SizedBox(width: 48.w),
              IconButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(routes.homeScreen);
                  }
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white.withOpacity(0.7),
                  size: 28.r,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.w),
                ),
                child: CustomUserAvatar(
                  radius: 80,
                  currentImageFile: widget.currentImageFile,
                  imagePathOrUrl: image,
                ),
              ),

              if (widget.showAddIcon)
                Positioned(
                  bottom: 5.h,
                  right: 5.w,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 45.r,
                      width: 45.r,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.w),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 24.r),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 12.h),
          Text(
            name ?? 'اسم المستخدم',
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
