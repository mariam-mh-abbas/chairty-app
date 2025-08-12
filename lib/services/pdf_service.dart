import 'dart:typed_data';

import 'package:charity_project/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Uint8List> fetchPdfBytes(String relativePath) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  final dio = Dio();
  final url =
      relativePath.startsWith('http') ? relativePath : '$baseUrl/$relativePath';

  final options = Options(responseType: ResponseType.bytes);
  if (token != null) {
    options.headers = {
      'Authorization': 'Bearer $token',
    };
  }

  try {
    final response = await dio.get(url, options: options);
    if (response.statusCode == 200 && response.data != null) {
      return Uint8List.fromList(response.data);
    } else {
      throw Exception('Failed to load PDF: ${response.statusCode}');
    }
  } on DioError catch (e) {
    throw Exception('Dio error fetching PDF: ${e.message}');
  } catch (e) {
    throw Exception('Unexpected error fetching PDF: $e');
  }
}

String constructPdfUrl(String relativePath) {
  if (relativePath.startsWith('http')) return relativePath;
  if (relativePath.startsWith('storage/')) {
    return '$baseUrl/$relativePath';
  } else {
    return '$baseUrl/storage/$relativePath';
  }
}
