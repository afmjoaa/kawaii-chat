import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kawaii_chat/notification/local_notification_service.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();

    LocalNotificationService.initialize();

    //receive message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage Called');
      print(message.data);
      print(message.notification?.title);
      print(message.notification?.body);
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp');
      print(message.data);
      print(message.notification?.title);
      print(message.notification?.body);
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    _listenToTokenRefresh();
  }

  static Future<String?> getFCMToken() async {
    return _firebaseMessaging.getToken();
  }

  static Future<void> _listenToTokenRefresh() async{
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      //TODO: update your new token with backend
      //api call
    });
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('handleBackgroundMessage');
  //TODO: Do something
}
