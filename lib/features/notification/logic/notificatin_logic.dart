import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/model/notification_model.dart';

class NotificationCubit extends Cubit<List<NotificationModel>> {
  NotificationCubit() : super([]);

  void addNotification(NotificationModel notification) {
    final newList = List<NotificationModel>.from(state)
      ..insert(0, notification);
    emit(newList);
  }

  Future<void> fetchNotifications() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    try {
      final response = await Supabase.instance.client
          .from('notifications')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      // التحويل الصحيح للقائمة
      final data = response as List<dynamic>;
      final List<NotificationModel> fetchedNotifs = data
          .map((e) => NotificationModel.fromJson(e))
          .toList();

      emit(fetchedNotifs);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
