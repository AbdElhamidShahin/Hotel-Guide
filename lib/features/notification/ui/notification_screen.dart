import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/notification/ui/widget/custom_item_notification.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../core/network/model/notification_model.dart';
import '../logic/notificatin_logic.dart';

class NotificationScreenListView extends StatefulWidget {
  const NotificationScreenListView({super.key});

  @override
  State<NotificationScreenListView> createState() =>
      _NotificationScreenListViewState();
}

class _NotificationScreenListViewState
    extends State<NotificationScreenListView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().fetchNotifications();
  }

  Map<String, List<NotificationModel>> _groupNotifications(
    List<NotificationModel> list,
  ) {
    Map<String, List<NotificationModel>> grouped = {};
    final now = DateTime.now();
    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    for (var notif in list) {
      String day;
      if (notif.time.year == now.year &&
          notif.time.month == now.month &&
          notif.time.day == now.day) {
        day = "اليوم";
      } else if (notif.time.year == yesterday.year &&
          notif.time.month == yesterday.month &&
          notif.time.day == yesterday.day) {
        day = "الأمس";
      } else {
        day = "${notif.time.year}/${notif.time.month}/${notif.time.day}";
      }
      grouped.putIfAbsent(day, () => []).add(notif);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        name: "الإشعارات",
        onTap: () {
          context.push(routes.homeScreen);
        },
      ),

      body: BlocBuilder<NotificationCubit, List<NotificationModel>>(
        builder: (context, notifications) {
          if (notifications.isEmpty) {
            return _buildEmptyState();
          }

          final groupedNotifs = _groupNotifications(notifications);

          return RefreshIndicator(
            onRefresh: () =>
                context.read<NotificationCubit>().fetchNotifications(),
            child: ListView.builder(
              itemCount: groupedNotifs.keys.length,
              itemBuilder: (context, index) {
                String day = groupedNotifs.keys.elementAt(index);
                List<NotificationModel> dayNotifs = groupedNotifs[day]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 20.w,
                        top: 40.h,
                        bottom: 10.h,
                      ),
                      child: Text(
                        day,
                        style: textStyle20BoldShadowPurple.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    ...dayNotifs
                        .map((n) => CustomItemNotification(notification: n))
                        .toList(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "لا توجد إشعارات حالياً",
            style: TextStyle(color: Colors.grey, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
