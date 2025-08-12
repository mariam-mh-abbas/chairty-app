// lib/services/message_service.dart
import 'package:charity_project/services/auth_service.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUsService {
  final Dio dio = Dio();

  Future<Response> SendMessage({
    required String phone,
    required String message,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = await SharedPrefs.getToken() ?? '';
    if (token == null) throw Exception('Token not found');

    return await dio.post(
      '$baseUrl/api/message/send',
      data: {
        "phone": phone,
        "message": message,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}
