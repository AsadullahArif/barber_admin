import 'dart:io';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:barberapp_admin/bottomnavi.dart';
import 'package:barberapp_admin/notification.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:barberapp_admin/adminPanel.dart';
import 'package:barberapp_admin/firebaseoption.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ?
  await Firebase.initializeApp(options: firebaseOptions) : await Firebase.initializeApp();
  await NotificationService().initialize();
  // AwesomeNotifications().initialize(
  //   'resource://drawable/res_app_icon', // Your app icon here
  //   [
  //     NotificationChannel(
  //       channelKey: 'basic_channel',
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic tests',
  //       defaultColor: const Color(0xFF9D50DD),
  //       ledColor: Colors.white,
  //     ),
  //   ],
  // );
  //  AwesomeNotifications().initialize(
  //   'resource://drawable/res_app_icon',
  //   [
  //     NotificationChannel(
  //       channelKey: 'basic_channel',
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic tests',
  //       defaultColor: const Color(0xFF9D50DD),
  //       ledColor: Colors.white,
  //       importance: NotificationImportance.High,
  //       channelShowBadge: true,
  //     ),
  //   ],
  // );
  // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  //   if (!isAllowed) {
  //     AwesomeNotifications().requestPermissionToSendNotifications();
  //   }
  // });

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   NotificationService.showNotification(message.notification);
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const BottomNavigation(),
    );
  }
}
