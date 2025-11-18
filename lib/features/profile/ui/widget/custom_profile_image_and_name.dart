import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:image_picker/image_picker.dart';

typedef ImagePickedCallback = void Function(File? file);

class CustomProfileImageAndName extends StatefulWidget {
  const CustomProfileImageAndName({
    super.key,
    this.showEditIcon = false,
    this.showAddIcon = false,
    this.onTap,
    this.currentImageFile,
    this.onImagePicked,
  });

  final bool showEditIcon;
  final bool showAddIcon;
  final VoidCallback? onTap;
  final File? currentImageFile;
  final ImagePickedCallback? onImagePicked;

  @override
  State<CustomProfileImageAndName> createState() =>
      _CustomProfileImageAndNameState();
}

class _CustomProfileImageAndNameState extends State<CustomProfileImageAndName> {
  String? name;
  String? image; // مسار الصورة المحفوظة (من الداتا بيز)

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    setState(() {
      name = " عبده شاهين";
    });
  }

  // دالة اختيار الصورة التي تستدعي دالة الأب للتحديث
  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        widget.onImagePicked!(File(pickedFile.path));
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
                  onPressed: () async {
                    context.go(routes.editAccountScreen);
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
                  Navigator.pop(context);
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
                  // استخدام currentImageFile لتحديد الصورة
                  backgroundImage: widget.currentImageFile != null
                      ? FileImage(widget.currentImageFile!)
                      : (image != null && File(image!).existsSync()
                            ? FileImage(File(image!))
                            : const AssetImage('assets/images/profile.png')
                                  as ImageProvider),
                ),
              ),

              if (widget.showAddIcon)
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFBD59),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF222222),
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
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
