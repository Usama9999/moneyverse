import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:talentogram/globals/services/local_notifications_helper.dart';

class FirebaseUtils {
  static Future<void> pushNotifications() async {
    // 2. Instantiate Firebase Messaging
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else {
      log('User declined or has not accepted permission');
    }
    messaging.subscribeToTopic('contests');
    FirebaseMessaging.instance.getInitialMessage().then((message) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      LocalNotificationChannel.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessage.listen((event) async {
      // var data = jsonEncode(event.data);
      // log("FCM data: $data");
    });
    var token = await messaging.getToken();
    log('token $token');
  }
}
