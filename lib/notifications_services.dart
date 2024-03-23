import 'dart:async';
import 'dart:math';

// import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  _printNotificationMessage(message);
}

void _printNotificationMessage(RemoteMessage message) {
  print('Title: ${message.notification?.title}');
  print('Message: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class NotificationsService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initNotifications() async {
    await _getRequest();
    _getDeviceToken().then((value) => print('FCM Token: $value'));
    _isTokenRefreshed();
    _initFirebaseNotifications();
    _initLocalNotifications();
  }

  Future _getRequest() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission granted ✅');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('provisional permission granted ✅');
    } else {
      // AppSettings.openAppSettings(type: AppSettingsType.notification);
      print('permission denied ❌');
    }
  }

  Future<String?> _getDeviceToken() async {
    return await _messaging.getToken();
  }

  void _isTokenRefreshed() {
    _messaging.onTokenRefresh.listen((event) {
      print(event);
    });
  }

  void _initFirebaseNotifications() {
    FirebaseMessaging.onMessage.listen((message) {
      print("Notification Received");
      _printNotificationMessage(message);
      if (message.notification != null) _showNotification(message);
    });
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  // These are because notifications don't show in forground
  void _initLocalNotifications() {
    var androidInitSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitSettings = const DarwinInitializationSettings();

    var initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );
    _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  // For forground using Flutter Local Notification package
  Future _showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      Random.secure().nextInt(10000).toString(),
      'High Importance Notifications',
      importance: Importance.max,
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    _localNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }
}
