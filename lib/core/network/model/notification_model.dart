import 'package:flutter/material.dart';

enum NotificationType { success, failure, reminder, message }

class NotificationModel {
  final String? id;
  final String title;
  final String body;
  final DateTime time;
  final NotificationType type;

  NotificationModel({
    this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      time: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      type: NotificationType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => NotificationType.message,
      ),
    );
  }

  Map<String, dynamic> toJson(String userId) {
    return {
      'user_id': userId,
      'title': title,
      'body': body,
      'type': type.name,
      'created_at': time.toIso8601String(),
    };
  }
}