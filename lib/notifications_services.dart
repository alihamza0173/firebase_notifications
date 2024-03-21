import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsService {
  final _messaging = FirebaseMessaging.instance;

  void getRequest() async {
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
      print('Permission granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('provisional permission granted');
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      print('permission denied');
    }
  }

  Future<String?> getDeviceToken() async {
    return await _messaging.getToken();
  }

  void isTokenRefresh() {
    _messaging.onTokenRefresh.listen((event) {
      print(event);
    });
  }
}
