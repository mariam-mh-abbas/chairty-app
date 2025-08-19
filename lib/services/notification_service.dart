// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotifications =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initNotifications() async {
//     if (Platform.isAndroid) {
//       await _messaging.requestPermission();
//       String? FCMtoken = await _messaging.getToken();
//       print("FCM Token: $FCMtoken");
//     } else {
//       print("FCM not supported on this platform");
//     }

//     String? FCMtoken = await _messaging.getToken();
//     if (FCMtoken != null) {
//       await sendFcmToken(FCMtoken);
//     }

//     // تهيئة الإشعارات المحلية
//     const AndroidInitializationSettings initSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initSettings = InitializationSettings(
//       android: initSettingsAndroid,
//     );

//     await _localNotifications.initialize(initSettings);

//     // استقبال الإشعار والتعامل معه وهو داخل التطبيق
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showLocalNotification(message);
//     });
//   }

//   Future<void> _showLocalNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'default_channel',
//       'Default',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//     );

//     await _localNotifications.show(
//       0,
//       message.notification?.title,
//       message.notification?.body,
//       details,
//     );
//   }

//   Future<void> sendFcmToken(String FCMtoken) async {
//     final Dio _dio = Dio();
//     await _dio.post(
//       'http://127.0.0.1:8000/api/save-fcm-token',
//       data: {'fcm_token': FCMtoken},
//     );
//   }
// }
