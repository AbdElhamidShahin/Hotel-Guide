import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/notification/ui/widget/custom_item_notification.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/colors.dart';

class NotificationScreenListView extends StatelessWidget {
  const NotificationScreenListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'الإشعارات',
          style: textStyle18BoldGray.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.black6,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: () {
              context.go(routes.homeScreen);
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: 5,
        itemBuilder: (context, index) {
          return CustomItemNotification();
        },
      ),
    );
  }
}
