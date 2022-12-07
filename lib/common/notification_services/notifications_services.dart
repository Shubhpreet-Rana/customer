import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

class NotificationServices {
  NotificationServices._private();

  static final NotificationServices instance = NotificationServices._private();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> get getDeviceToken async {
    return await _firebaseMessaging.getToken() ?? "";
  }

  void get getInitialMessage {
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      debugPrint("Firebase Initial Message ${message?.notification?.title}");
    });
  }

  void get onMessage {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Firebase onMessage ${message.notification?.body}");
    });
  }

  void get onMessageOpenedApp {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Firebase onMessageOpenedApp ${message.notification?.title}");
    });
  }

  void get onBackgroundMessage {
   try {
      FirebaseMessaging.onBackgroundMessage(
        (RemoteMessage message) async {
          debugPrint("Firebase onBackgroundMessage ${message.notification?.title}");
        },
      );
    } catch(e) {
     debugPrint(e.toString());
   }
  }

  void get permissions async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  void get setForegroundNotificationPresentationOptions async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
