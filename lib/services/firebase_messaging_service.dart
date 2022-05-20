import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:galss/config/constants.dart';
import 'package:galss/firebase_options.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_login.dart';
import 'package:galss/pages/chat_room.dart';
import 'package:galss/repository/chat_repository.dart';
import 'package:galss/services/auth_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/services/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel androidNotificationChannel =
    const AndroidNotificationChannel('android_notification_channel_01', 'galss',
        description: 'Galss notification channel', importance: Importance.high);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

BehaviorSubject<RemoteMessage> onMessageReceived = BehaviorSubject();

Future<void> handleBackgroundMessaging(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class FirebaseMessagingService {
  FirebaseMessagingService();

  Future load() async {
    final deviceToken = await firebaseMessaging.getToken();

    final authData =
        await SharedPreferencesService().getItem(SharedPrefs.authData);

    final tokenUpdateResponse = await locator<AuthService>().postNewDeviceToken(
        deviceToken,
        apiLogin: ApiLogin.fromJson(jsonDecode(authData ?? "{}")));

    initMessaging();
  }

  Future<void> initMessaging() async {
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = const IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
    flutterLocalNotificationsPlugin.initialize(initSetting);

    firebaseMessaging.setForegroundNotificationPresentationOptions(
        badge: true, alert: true);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    var androidDetails = AndroidNotificationDetails(
        androidNotificationChannel.id, androidNotificationChannel.name,
        channelShowBadge: true,
        visibility: NotificationVisibility.public,
        priority: Priority.max);
    var iosDetails = const IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging);

    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      final notificationData = event.data;

      if (notificationData['notificationType'] != 'chat') {
        return;
      }

      final chatRoomId = notificationData['chatId'];

      final chatId =
          await ChatRepository().fetchChatById(int.parse(chatRoomId));

      locator<NavigationService>().navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (builder) => ChatRoom(chat: chatId)));
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      onMessageReceived.add(message);
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title, notification.body, generalNotificationDetails);
      }
    });
  }
}
