import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:charity_project/view/set_language_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LanguageService {
  final Dio _dio = Dio();

  Future<void> ChangeLanguage(String languageCode) async {
    final token = await SharedPrefs.getToken();
    if (token == null) return;

    try {
      final response = await _dio.post(
        '$baseUrl/api/setLanguage',
        data: {
          'preferred_language': languageCode,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to set language: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final message = e.response!.data is Map
            ? (e.response!.data['message'] ?? e.response!.data.toString())
            : e.response!.data.toString();
        throw Exception(message);
      } else {
        throw Exception('Connection error');
      }
    }
  }
}
