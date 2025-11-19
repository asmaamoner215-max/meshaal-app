import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../cache_helper/cache_keys.dart';
import '../cache_helper/shared_pref_methods.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Background/terminated messages handler
  // You can add logging or analytics here if needed
  // print('BG message id: ${message.messageId}');
}

class MessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // Request notification permissions (Android 13+ & iOS)
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Register background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Get token
    final token = await _messaging.getToken();
    if (token != null) {
      await CacheHelper.saveData(key: CacheKeys.fcmToken, value: token);
      // ignore: avoid_print
      print('FCM token: $token');
    }

    // Listen for token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await CacheHelper.saveData(key: CacheKeys.fcmToken, value: newToken);
      // ignore: avoid_print
      print('FCM token refreshed: $newToken');
      // Optionally: call backend to update the device token for the logged-in user
    });

    // Foreground messages (optional basic log)
    FirebaseMessaging.onMessage.listen((message) {
      // ignore: avoid_print
      print('FCM onMessage: ${message.notification?.title} - ${message.notification?.body}');
    });
  }
}
