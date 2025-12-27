import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:image_picker/image_picker.dart';

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
  });

  final bool showEditIcon;
  final bool showAddIcon;
  final VoidCallback? onTap;
  final File? currentImageFile;
  final ImagePickedCallback? onImagePicked;
  final String? name;
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
    setState(() {
      name = userData['name'] ?? widget.name;
      image = userData['imagePath'];
    });
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
      padding: const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF010101), Color(0xFF2C2C2C)],
          stops: [0.05, 1.0],
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
                  onPressed: () {
                    context.go(
                      routes.editAccountScreen,
                      extra: {'name': name ?? widget.name ?? ''},
                    );
                  },
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.white.withOpacity(0.7),
                    size: 32,
                  ),
                )
              else
                const SizedBox(width: 48),

              IconButton(
                onPressed: () {
                  context.go(routes.homeScreen);
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white.withOpacity(0.7),
                  size: 28,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[800],
                  backgroundImage: image != null && File(image!).existsSync()
                      ? FileImage(File(image!))
                      : const AssetImage('assets/images/profile.png')
                            as ImageProvider,
                ),
              ),

              if (widget.showAddIcon)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color:AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:  Colors.white,
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            name ?? 'اسم المستخدم',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
