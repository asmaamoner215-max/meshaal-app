import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:weam/core/cache_helper/cache_keys.dart';
import 'package:weam/core/cache_helper/shared_pref_methods.dart';
import '../notification/notification_strings.dart';

/// Global background message handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await MessagingService().displayPushNotification(message);
}

class MessagingService {
  factory MessagingService() => _instance;
  MessagingService._internal();
  static final MessagingService _instance = MessagingService._internal();

  static FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin => FlutterLocalNotificationsPlugin();

  static final StreamController<RemoteMessage?> _messageStreamController =
      StreamController<RemoteMessage?>.broadcast();

  static Stream<RemoteMessage?> get onMessageStream => _messageStreamController.stream;

  static bool _isInitialized = false;

  /// Initialize Firebase Messaging and Local Notifications
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Request permissions
      await _requestPermissions();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Setup Firebase Messaging handlers
      _setupFirebaseMessagingHandlers();

      // Get and save FCM token
      await _saveFCMToken();

      _isInitialized = true;
      print('✅ MessagingService initialized successfully');
    } catch (e) {
      print('❌ Error initializing MessagingService: $e');
    }
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      final androidPlugin =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final granted = await androidPlugin?.requestNotificationPermission() ?? true;
      print('Android notification permission: $granted');
    } else if (Platform.isIOS) {
      final iOSPlugin = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      await iOSPlugin?.requestPermissions(alert: true, badge: true, sound: true);
      print('iOS notification permission requested');
    }

    // Request Firebase Messaging permissions
    final settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('Firebase Messaging permission: ${settings.authorizationStatus}');
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    final initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
    );

    // Create Android notification channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    print('✅ Local notifications initialized');
  }

  /// Setup Firebase Messaging message handlers
  void _setupFirebaseMessagingHandlers() {
    // Handle messages when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📬 Foreground message received');
      displayPushNotification(message);
      _messageStreamController.add(message);
    });

    // Handle messages when app is opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🚀 App opened from notification');
      _messageStreamController.add(message);
    });

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  /// Save FCM token to cache and send to backend
  Future<void> _saveFCMToken() async {
    try {
      final token = await firebaseMessaging.getToken();
      if (token != null) {
        await CacheHelper.saveData(key: CacheKeys.fcmToken, value: token);
        print('💾 FCM Token saved: $token');
      }
    } catch (e) {
      print('❌ Error getting FCM token: $e');
    }
  }

  /// Display local notification
  Future<void> displayPushNotification(RemoteMessage message) async {
    try {
      final title = message.notification?.title ?? message.data['title'] ?? 'إشعار جديد';
      final body = message.notification?.body ?? message.data['body'] ?? '';

      print('🔔 Displaying notification: $title');

      await flutterLocalNotificationsPlugin.show(
        _createUniqueId(),
        title,
        body,
        pushNotificationDetails,
        payload: message.data.toString(),
      );
    } catch (e) {
      print('❌ Error displaying notification: $e');
    }
  }

  /// Handle notification tap
  static void _onNotificationTap(NotificationResponse response) {
    print('👆 Notification tapped: ${response.payload}');
    // Handle notification tap action here
    // You can navigate to specific screens based on the payload
  }

  /// Generate unique notification ID
  static int _createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  /// Get FCM token
  static Future<String?> getFCMToken() async {
    return CacheHelper.getData(key: CacheKeys.fcmToken);
  }

  /// Delete FCM token (for logout)
  static Future<void> deleteToken() async {
    try {
      await firebaseMessaging.deleteToken();
      await CacheHelper.removeData(key: CacheKeys.fcmToken);
      print('✅ FCM Token deleted');
    } catch (e) {
      print('❌ Error deleting FCM token: $e');
    }
  }

  /// Listen to token refresh
  static Stream<String> get onTokenRefresh => firebaseMessaging.onTokenRefresh;
}
