import 'dart:io';
import 'package:charity_project/firebase_options.dart';
import 'package:charity_project/models/notification_model.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/shared_prefs.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (!Platform.isWindows) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    const android = AndroidNotificationDetails(
      'default_channel',
      'Default',
      importance: Importance.max,
      priority: Priority.high,
    );

    final local = FlutterLocalNotificationsPlugin();
    await local.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher')),
    );

    local.show(
      0,
      message.notification?.title ?? message.data['title'] ?? '',
      message.notification?.body ?? message.data['body'] ?? '',
      NotificationDetails(android: android),
    );
  }
}

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final Dio dio = Dio();

  Future<void> init() async {
    if (Platform.isWindows) return;

    // Local notifications initialization
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (details) {
      // handle notification tap
      print("Tapped notification: ${details.payload}");
    });

    // Permissions
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    // Background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    // Opened from background/terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_handleClick);
    final initial = await _messaging.getInitialMessage();
    if (initial != null) _handleClick(initial);
  }

  void _handleClick(RemoteMessage message) {
    print("User clicked notification: ${message.data}");
    // هنا ممكن تضيفي نافذة فتح صفحة معينة بناءً على message.data['id']
  }

  void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    flutterLocalNotificationsPlugin.show(
      notification?.hashCode ?? 0,
      notification?.title ?? message.data['title'] ?? '',
      notification?.body ?? message.data['body'] ?? '',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'General Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  Future<String?> getFcmTokenSafe() async {
    if (Platform.isAndroid || Platform.isIOS) return _messaging.getToken();
    return null;
  }

  void listenTokenRefresh(Function(String) onRefresh) {
    if (Platform.isAndroid || Platform.isIOS)
      _messaging.onTokenRefresh.listen(onRefresh);
  }

  Future<List<NotificationModel>?> getAllNotifications() async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) return null;

    final response = await dio.get(
      '$baseUrl/api/getAllNotifications',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  Future<bool> deleteAllNotifications() async {
    try {
      final token = await SharedPrefs.getToken();
      final response = await dio.delete(
        '$baseUrl/api/deleteAllNotifications',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Failed to delete all notifications: $e");
    }
  }

  Future<bool> deleteNotificationById(int id) async {
    try {
      final token = await SharedPrefs.getToken();
      final response = await dio.delete(
        '$baseUrl/api/deleteNotification/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Failed to delete notification: $e");
    }
  }
}
