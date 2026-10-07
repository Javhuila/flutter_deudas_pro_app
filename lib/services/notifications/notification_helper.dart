import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  NotificationHelper._();

  static AndroidNotificationDetails android({required String channel}) {
    return AndroidNotificationDetails(
      channel,
      channel,
      importance: Importance.max,
      priority: Priority.high,
    );
  }

  static NotificationDetails details({required String channel}) {
    return NotificationDetails(android: android(channel: channel));
  }
}
