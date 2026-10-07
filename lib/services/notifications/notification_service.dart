import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'package:timezone/timezone.dart' as tz;

import 'notification_channels.dart';
import 'notification_helper.dart';
import 'notification_permission.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android);

    await plugin.initialize(settings);

    await NotificationPermission.request(plugin);
  }

  Future<void> show({
    required int id,
    required String title,
    required String body,
    String channel = NotificationChannels.recordatorios,
  }) async {
    await plugin.show(
      id,
      title,
      body,
      NotificationHelper.details(channel: channel),
    );
  }

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    String channel = NotificationChannels.recordatorios,
  }) async {
    // print('SCHEDULE 1');
    await plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      NotificationHelper.details(channel: channel),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
    // print('SCHEDULE 2');
  }

  Future<void> scheduleTestNotification() async {
    // print('TEST 1: iniciando prueba');
    final scheduledDate = tz.TZDateTime.now(
      tz.local,
    ).add(const Duration(seconds: 30));
    // print('TEST 2: fecha programada = $scheduledDate');
    await schedule(
      id: 9999,
      title: 'Prueba de notificaciones',
      body: 'La programación de notificaciones está funcionando correctamente.',
      scheduledDate: scheduledDate,
    );
    // print('TEST 3: notificación programada');
  }

  Future<void> cancel(int id) async {
    await plugin.cancel(id);
  }

  Future<void> cancelAll() async {
    await plugin.cancelAll();
  }

  Future<List<PendingNotificationRequest>> pendingNotifications() async {
    return plugin.pendingNotificationRequests();
  }
}
