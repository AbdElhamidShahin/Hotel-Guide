import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/model/notification_model.dart';

// ── States ────────────────────────────────────────────────────────────────────

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationLoaded(this.notifications);
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}

// ── Cubit ─────────────────────────────────────────────────────────────────────

/// ✅ Fix: NotificationCubit now uses a proper state system
/// instead of emitting raw List<T> with no loading/error states.
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void addNotification(NotificationModel notification) {
    final currentList = state is NotificationLoaded
        ? (state as NotificationLoaded).notifications
        : <NotificationModel>[];
    final newList = [notification, ...currentList];
    emit(NotificationLoaded(newList));
  }

  Future<void> fetchNotifications() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      emit(NotificationError('يرجى تسجيل الدخول أولاً'));
      return;
    }

    emit(NotificationLoading());

    try {
      final response = await Supabase.instance.client
          .from(AppTableNames.notifications)
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      final List<NotificationModel> fetched = (response as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e))
          .toList();

      emit(NotificationLoaded(fetched));
    } catch (e) {
      debugPrint('❌ fetchNotifications: $e');
      emit(NotificationError('فشل تحميل الإشعارات، حاول مرة أخرى.'));
    }
  }
}
