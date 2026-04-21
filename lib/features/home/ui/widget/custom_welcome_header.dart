import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import '../../../../core/helpers/custom_user_avatar.dart';
import '../../../../core/helpers/local_storage_account.dart';
import '../../../../core/router/routers.dart';

class CustomWelcomeHeader extends StatefulWidget {
  const CustomWelcomeHeader({
    super.key,
    required this.name,
    this.imageUrl,
    this.currentImageFile,
  });
  final String? name;
  final String? imageUrl;
  final File? currentImageFile;
  @override
  State<CustomWelcomeHeader> createState() => _CustomWelcomeHeaderState();
}

class _CustomWelcomeHeaderState extends State<CustomWelcomeHeader> {
  String? name;
  String? image;

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  context.push(routes.menuScreen);
                },
                icon: Icon(Icons.menu_outlined, size: 34),
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Text(
                        "مرحبًا ${name}",
                        style: font23SemiBoldBlack,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Image.asset(
                        "assets/images/hi.png",
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  context.push(
                    routes.accountScreen,
                    extra: {'name': name ?? widget.name ?? ''},
                  );
                },
                child: SizedBox(
                  height: 60.h,
                  width: 60.w,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: CustomUserAvatar(
                      radius: 80,
                      currentImageFile: widget.currentImageFile,
                      imagePathOrUrl: image,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "كل ما تحتاجه للإقامة المثالية أصبح بين يديك الآن.",
            style: font17MediumBlack.copyWith(fontSize: 14.sp),
            textDirection: TextDirection.rtl,

            textAlign: TextAlign.start,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
