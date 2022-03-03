import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingUtils {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  StreamSubscription? streamSubscription;

  FirebaseMessagingUtils() {
    streamSubscription = firebaseMessaging.onTokenRefresh.listen((event) {});
  }

  dispose() {
    streamSubscription?.cancel();
  }
}
