import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_noti_android/main.dart';

class FirebaseApi {
  // function to handle Firebase Messenging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to handle notifications
  Future<void> initNotifications() async {
    // permission from user (prompt)
    await _firebaseMessaging.requestPermission();

    // fetching FCM token for the device
    final fCMToken = await _firebaseMessaging.getToken();

    // print the token
    print('Token: $fCMToken');

    // initialize for further
    initPushNotifications();
  }

  // function to handle received messages
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  // function to hanfle foreground and background processes
  Future initPushNotifications() async {
    // handle notification if the app is terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // event listeners attached when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
