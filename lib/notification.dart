// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permissions for iOS
    await _firebaseMessaging.requestPermission();
    final fcmtoken = await _firebaseMessaging.getToken();
    print('token:$fcmtoken');

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(showNotification);

    // Handle foreground messages
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   showNotification(message.notification);
    // });
  }

  // static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   showNotification(message.notification);
  // }

  static Future<void> showNotification(RemoteMessage message) async {
    print('title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('title: ${message.data}');
    // if (notification != null) {
    //   AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: 10,
    //       channelKey: 'basic_channel',
    //       title: notification.title,
    //       body: notification.body,
    //     ),
    //   );
    // }
  }
}
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;

//   Future<void> initialize() async {
//     // Request permission for iOS
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }

//     // Handle the initial message
//     RemoteMessage? initialMessage = await _fcm.getInitialMessage();
//     if (initialMessage != null) {
//       _handleMessage(initialMessage);
//     }

//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen(_handleMessage);

//     // Handle background messages
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

//     // Subscribe to a topic if needed
//     // await _fcm.subscribeToTopic('orders');
//   }

//   void _handleMessage(RemoteMessage message) {
//     // Handle the notification
//     if (message.notification != null) {
//       print('Message also contained a notification: ${message.notification}');
//       // Show notification using Awesome Notifications
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 10,
//           channelKey: 'basic_channel',
//           title: message.notification?.title,
//           body: message.notification?.body,
//           notificationLayout: NotificationLayout.Default,
//         ),
//       );
//     }
//   }
// }
