import 'dart:io';

import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:charity_project/models/profile_model.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProfileModel?> ShowProfile() async {
  final dio = Dio();
  final prefs = await SharedPreferences.getInstance();
  final token = await SharedPrefs.getToken() ?? '';

  try {
    final response = await dio.get(
      '$baseUrl/api/user/showProfile',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    print('Show Profile Response: ${response.data}');

    final data = response.data['data'];
    return ProfileModel.fromJson(data);
  } catch (e) {
    throw Exception('Failed to load profile: $e');
  }
}

Future<ProfileModel> updateProfile({
  required name,
  File? image,
  required token,
}) async {
  final dio = Dio();

  FormData formData = FormData.fromMap({
    'name': name,
    if (image != null)
      'profile_image':
          await MultipartFile.fromFile(image.path, filename: 'profile.jpg'),
  });

  final response = await dio.post(
    '$baseUrl/api/user/updateProfile',
    data: formData,
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );

  if (response.statusCode == 200) {
    print('Update Response: ${response.data}');
    return ProfileModel.fromJson(response.data['data']);
  } else {
    throw Exception('Failed to update profile');
  }
}
