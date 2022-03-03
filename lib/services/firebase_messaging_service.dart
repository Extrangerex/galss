import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:galss/main.dart';
import 'package:galss/services/auth_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data);
}

class FirebaseMessagingService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  StreamSubscription? streamSubscription;

  FirebaseMessagingService() {
    load();
  }

  Future load() async {
    final deviceToken = await firebaseMessaging.getToken();

    final tokenUpdateResponse =
        await locator<AuthService>().postNewDeviceToken(deviceToken);

    debugPrint("${tokenUpdateResponse?.message}");

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await initialize();
  }

  Future initialize() async {
    await firebaseMessaging.getInitialMessage();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  dispose() {
    streamSubscription?.cancel();
  }
}
