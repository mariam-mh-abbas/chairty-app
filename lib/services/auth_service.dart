import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/models/auth_model.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Auth_model> registerUser({
    required name,
    required phone,
    required password,
    required passwordConfirmation,
    required otp,
    required preferredLanguage,
  }) async {
    final language = await SharedPrefs.getLanguage();
    try {
      final response = await _dio.post(
        '$baseUrl/api/user/register',
        data: {
          'name': name,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'otp': otp,
          'preferred_language': language,
        },
      );
      // print('✅ Response data: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Auth_model.fromJson(response.data);
      } else {
        throw Exception('Registration failed: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // print('❌ Dio Error Response: ${e.response!.data}');
        throw Exception(e.response!.data['message'] ?? 'Unknown error');
      } else {
        // print('❌ Dio Connection error: ${e.message}');
        throw Exception('Connection error');
      }
    }
  }

  Future<Auth_model1> loginUser({
    required phone,
    required password,
  }) async {
    try {
      final response = await _dio.post(
        '$baseUrl/api/user/login',
        data: {
          'phone': phone,
          'password': password,
        },
      );
      return Auth_model1.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print('Login Error: ${e.response!.data}');
      } else {
        print('Connection error: ${e.message}');
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    final token = await SharedPrefs.getToken();
    try {
      final response = await Dio().post(
        '$baseUrl/api/user/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("User logged out successfully.");
      }
    } catch (e) {
      print("Logout failed: $e");
      rethrow;
    }
  }

  Future<GoogleLoginResponse> loginWithGoogle({
    required String accessToken,
    required preferredLanguage,
  }) async {
    final language = await SharedPrefs.getLanguage();
    try {
      final response = await _dio.post(
        '$baseUrl/api/user/google',
        data: {
          'access_token': accessToken,
          'preferred_language': language,
        },
      );

      return GoogleLoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print('Google login error: ${e.response!.data}');
      } else {
        print('Connection error: ${e.message}');
      }
      rethrow;
    }
  }
}
