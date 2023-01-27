import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_notification_handler.dart';

String deviceTokenToSendPushNotification = '';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseNotification(context) async {
  /// ** Here managed the app is in different state
  /// 1. This method call when app in terminated state and you get a notification
  /// In this method , when you click on notification app open from terminated state and you can get notification data
  debugPrint("-------------------- FirebaseMessaging -----------------------");
  FirebaseMessaging.instance.getInitialMessage().then(
    (message) {
      /// here app is a background state
      debugPrint("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message?.notification != null) {
        final Map<String, String> finalPayLoadData =
            Map<String, String>.from(message!.data);
        debugPrint(
            'App is a background state ------------------$finalPayLoadData');
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          debugPrint(
            'A new onMessageOpenedApp event was published!-------------${message.data}----',
          );
        });
      }
    },
  );

  ///2. This method only call when App in foreground it mean app must be opened
  FirebaseMessaging.onMessage.listen(
    (message) {
      debugPrint("FirebaseMessaging.onMessage.listen");

      /// here app is a  live state
      if (message.notification != null) {
        debugPrint("App is live state :  ${message.toMap()}");

        LocalNotificationService.createAndDisplayNotification(
          message: message,
          flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        );
      }
    },
  );

  /// 3. This method only call when App in background and not terminated
  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) {
      debugPrint("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        final Map<String, String> finalPayLoadData =
            Map<String, String>.from(message.data);

        debugPrint(
          "------background---------finalPayLoadData--------------:: $finalPayLoadData",
        );
      } else {
        debugPrint(message.data.toString());
        debugPrint(message.notification.toString());
        debugPrint(">>>>>>>>>>>>>>>>>>>>");
      }
    },
  );

  /// Get our device token here
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  final token = await fcm.getToken();
  deviceTokenToSendPushNotification = token.toString();
  debugPrint("My Device Token :::::: $deviceTokenToSendPushNotification");
}