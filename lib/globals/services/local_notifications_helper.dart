import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationChannel {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static initializer() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings(
                onDidReceiveLocalNotification: onDidReceiveLocalNotification));

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTap,
        onDidReceiveBackgroundNotificationResponse: onTap);
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails != null) {
      if (notificationAppLaunchDetails.notificationResponse != null) {
        // if (notificationAppLaunchDetails.notificationResponse!.payload ==
        //     "Activity") {
        //   Get.to(() => ActivityDashboard());
        // } else if (notificationAppLaunchDetails.notificationResponse!.payload ==
        //     "ToDo") {
        //   Get.to(() => ToDoScreen());
        // } else if (notificationAppLaunchDetails.notificationResponse!.payload ==
        //     "fasting") {
        //   Get.to(() => FastingTracker());
        // }
      }
    }
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
              'high_importance_channel', 'high_importance_channel channal',
              importance: Importance.max, priority: Priority.max));
      await _flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails);
    } catch (e) {
      log(e.toString());
    }
  }

  // static Future<void> displayScheduled(title, body, DateTime dateTime) async {
  //   try {
  //     final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //     NotificationDetails notificationDetails = NotificationDetails(
  //         android: AndroidNotificationDetails(
  //             'high_importance_channel', 'high_importance_channel channal',
  //             importance: Importance.max, priority: Priority.max));
  //     await _flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
  //         tz.TZDateTime.from(dateTime, tz.local), notificationDetails,
  //         payload: "",
  //         androidAllowWhileIdle: true,
  //         uiLocalNotificationDateInterpretation:
  //             UILocalNotificationDateInterpretation.absoluteTime);
  //     log(dateTime.toString());
  //   } catch (e) {
  //     log(e);
  //   }
  // }

  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}

  static void onTap(NotificationResponse details) {}
}
