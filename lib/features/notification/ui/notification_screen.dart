import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme_data.dart';
import 'package:hotel_guide/core/theme/colors.dart';
import 'package:hotel_guide/features/notification/ui/widget/custom_item_notification.dart';
import '../../../core/helpers/contact/build_notification_notfound.dart';
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
    final Map<String, List<NotificationModel>> grouped = {};
    final now       = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    for (final notif in list) {
      final String day;
      if (notif.time.year == now.year &&
          notif.time.month == now.month &&
          notif.time.day == now.day) {
        day = 'اليوم';
      } else if (notif.time.year == yesterday.year &&
          notif.time.month == yesterday.month &&
          notif.time.day == yesterday.day) {
        day = 'الأمس';
      } else {
        day = '${notif.time.year}/${notif.time.month}/${notif.time.day}';
      }
      grouped.putIfAbsent(day, () => []).add(notif);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Inherits scaffoldBackgroundColor from AppThemeData automatically.
      appBar: CustomAppbarWidget(
        name: 'الإشعارات',
        onTap: () => context.pop(),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Migrated from frozen font20BoldShadowPurple global.
                  Text(
                    state.message,
                    style: AppTextStyles.font20BoldShadowPurple(context)
                        .copyWith(color: AppColors.primary),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<NotificationCubit>().fetchNotifications(),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          final notifications = state is NotificationLoaded
              ? state.notifications
              : <NotificationModel>[];

          if (notifications.isEmpty) return BuildNotFoundNotification();

          final grouped = _groupNotifications(notifications);

          return RefreshIndicator(
            onRefresh: () =>
                context.read<NotificationCubit>().fetchNotifications(),
            child: ListView.builder(
              itemCount: grouped.keys.length,
              itemBuilder: (context, i) {
                final day      = grouped.keys.elementAt(i);
                final dayItems = grouped[day]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 20.w,
                        top: 40.h,
                        bottom: 10.h,
                      ),
                      // Migrated from frozen font20BoldShadowPurple global.
                      child: Text(
                        day,
                        style: AppTextStyles.font20BoldShadowPurple(context)
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                    ...dayItems.map(
                      (n) => CustomItemNotification(notification: n),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
