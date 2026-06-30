import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/model/notification_model.dart';


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


class NotificationCubit extends Cubit<NotificationState> {
  final SupabaseClient _supabase;

  NotificationCubit(this._supabase) : super(NotificationInitial());

  void addNotification(NotificationModel notification) {
    final currentList = state is NotificationLoaded
        ? (state as NotificationLoaded).notifications
        : <NotificationModel>[];
    emit(NotificationLoaded([notification, ...currentList]));
  }

  Future<void> fetchNotifications() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      emit(NotificationError('يرجى تسجيل الدخول أولاً'));
      return;
    }

    emit(NotificationLoading());

    try {
      final response = await _supabase
          .from(AppTableNames.notifications)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final fetched = (response as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();

      emit(NotificationLoaded(fetched));
    } on PostgrestException catch (e) {
      debugPrint('❌ fetchNotifications (Postgrest): ${e.message}');
      emit(NotificationError('فشل تحميل الإشعارات، حاول مرة أخرى.'));
    } catch (e) {
      debugPrint('❌ fetchNotifications: $e');
      emit(NotificationError('حدث خطأ غير متوقع.'));
    }
  }
}
