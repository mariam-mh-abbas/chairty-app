// services/device_service.dart
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/services/notification_service.dart';
import 'package:dio/dio.dart';

class DeviceService {
  final Dio _dio = Dio();

  Future<void> registerDevice({required String fcmToken}) async {
    try {
      final token = await SharedPrefs.getToken();

      final response = await _dio.post(
        '$baseUrl/api/registerDevice',
        data: {
          'fcm_token': fcmToken,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("✅ Device registered: ${response.data}");
    } catch (e) {
      print("❌ registerDevice error: $e");
    }
  }

  Future<void> deregisterDevice({required String fcmToken}) async {
    try {
      final token = await SharedPrefs.getToken();

      final response = await _dio.post(
        '$baseUrl/api/deregisterDevice',
        data: {
          'fcm_token': fcmToken,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("✅ Device deregisterDevice: ${response.data}");
    } catch (e) {
      print("❌ deregisterDevice error: $e");
    }
  }
}
