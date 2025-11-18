import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// تأكد من استيراد ملفاتك الخاصة بشكل صحيح
import '../../../../core/theme/app_theme.dart';
import '../edit_account_screen.dart';

class CustomProfileImageAndName extends StatefulWidget {
  const CustomProfileImageAndName({
    super.key,
    this.showEditIcon = false, // افتراضيا مخفية
    this.showAddIcon = false,  // افتراضيا مخفية
    this.onTap, // جعلته اختياري لأنه قد لا يُستخدم إذا اعتمدنا على _pickImage الداخلي
  });

  final bool showEditIcon;
  final bool showAddIcon;
  final VoidCallback? onTap;

  @override
  State<CustomProfileImageAndName> createState() =>
      _CustomProfileImageAndNameState();
}

class _CustomProfileImageAndNameState extends State<CustomProfileImageAndName> {
  String? name;
  String? image; // مسار الصورة المحفوظة من الداتا بيز أو اللوكال
  File? _imageFile; // الصورة التي يتم اختيارها الآن من المعرض

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  // محاكاة تحميل البيانات
  Future<void> loadUserData() async {
    setState(() {
      name = "شادي عبده أبودنيا";
      // image = "path/to/saved/image"; // لو عندك مسار محفوظ ضعه هنا
    });
  }

  // دالة اختيار الصورة
  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
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
          // --- الصف العلوي (أيقونة الإعدادات والسهم) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.showEditIcon)
                IconButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  EditAccountScreen(),
                      ),
                    );
                    if (result == true) await loadUserData();
                  },
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.white.withOpacity(0.7),
                    size: 32,
                  ),
                )
              else
                const SizedBox(width: 48), // حفظ مسافة لتوازن الصف

              IconButton(
                onPressed: () {
                  // أضف أكشن الرجوع هنا
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

          // --- الصورة الشخصية مع زر الإضافة ---
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              // 1. الصورة الأساسية
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[800],
                  // المنطق: لو اخترت صورة جديدة اعرضها، لو لأ اعرض المحفوظة، لو مفيش اعرض الافتراضية
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : (image != null && File(image!).existsSync()
                      ? FileImage(File(image!))
                      : const AssetImage('assets/images/profile.png')
                  as ImageProvider),
                ),
              ),

              // 2. أيقونة الزائد (تظهر فقط بناء على الشرط)
              if (widget.showAddIcon)
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: _pickImage, // استدعاء دالة اختيار الصورة عند الضغط
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFBD59), // اللون البرتقالي
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF222222), // لون الخلفية الداكن (لعمل تأثير القطع)
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

          // --- الاسم ---
          Text(
            name ?? 'اسم المستخدم',
            // تأكد من ضبط الستايل حسب ملفاتك
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo', // مثال
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}