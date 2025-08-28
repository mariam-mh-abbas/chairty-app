import 'dart:core';

import 'package:charity_project/models/reset_password_model.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:dio/dio.dart';

Future<ResetPasswordModel> resetPassword({
  required phone,
  required password,
  required passwordConfirmation,
  required otp,
}) async {
  try {
    final response = await Dio().post(
      '$baseUrl/api/user/resetPassword',
      data: {
        'phone': phone,
        'new_password': password,
        'new_password_confirmation': passwordConfirmation,
        'otp': otp,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ResetPasswordModel.fromJson(response.data);
    } else {
      throw Exception('Registration failed: ${response.data}');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      throw Exception(e.response!.data['message'] ?? 'Unknown error');
    } else {
      throw Exception('Connection error');
    }
  }
}
