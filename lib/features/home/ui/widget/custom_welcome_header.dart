import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
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

  @override
  void initState() {
    super.initState();
    // ✅ Fix #1: نسمع لـ UserDataNotifier بدل تحميل البيانات مرة واحدة بس.
    // كان initState يقرأ من SharedPreferences مرة واحدة فقط، فلو غيّر
    // المستخدم صورته من صفحة البروفايل، الهوم سكرين ما كانت تتحدث إلا
    // بعد إعادة فتح التطبيق بالكامل.
    UserDataNotifier.instance.addListener(_onUserDataChanged);
    _syncFromNotifier();
  }

  void _syncFromNotifier() {
    final notifier = UserDataNotifier.instance;
    if (notifier.name.isNotEmpty || notifier.image.isNotEmpty) {
      setState(() {
        name = notifier.name.isNotEmpty ? notifier.name : widget.name;
        image = notifier.image.isNotEmpty ? notifier.image : widget.imageUrl;
      });
    } else {
      loadUserData();
    }
  }

  void _onUserDataChanged() {
    if (!mounted) return;
    setState(() {
      name = UserDataNotifier.instance.name.isNotEmpty
          ? UserDataNotifier.instance.name
          : widget.name;
      image = UserDataNotifier.instance.image.isNotEmpty
          ? UserDataNotifier.instance.image
          : widget.imageUrl;
    });
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
  void dispose() {
    UserDataNotifier.instance.removeListener(_onUserDataChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
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
                onPressed: () => context.push(routes.menuScreen),
                icon: Icon(
                  Icons.menu_outlined,
                  size: 34,
                  // onSurface = primary text — adapts in dark mode.
                  color: cs.onSurface,
                ),
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Text(
                        'مرحبًا $name',
                        // Migrated from frozen font23SemiBoldBlack.
                        style: AppTextStyles.font23SemiBoldBlack(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Image.asset(
                        'assets/images/hi.png',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
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
                      border: Border.all(color: cs.outline, width: 2),
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
            'كل ما تحتاجه للإقامة المثالية أصبح بين يديك الآن.',
            // Migrated from frozen font17MediumBlack.
            style: AppTextStyles.font17MediumBlack(context)
                .copyWith(fontSize: 14.sp),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.start,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
