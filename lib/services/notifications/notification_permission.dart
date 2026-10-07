import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPermission {
  NotificationPermission._();

  static Future<void> request(FlutterLocalNotificationsPlugin plugin) async {
    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }
}
