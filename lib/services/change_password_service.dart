import 'package:charity_project/services/auth_service.dart';
import 'package:dio/dio.dart';

Future<void> changePassword({
  required String token,
  required String oldPassword,
  required String newPassword,
  required String newPasswordConfirmation,
}) async {
  final Dio dio = Dio();
  try {
    final response = await dio.post(
      '$baseUrl/api/user/changePassword',
      data: {
        'current_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        return response.data['message'];
      } else {
        return response.data();
      }
    } else {
      throw Exception('failed: ${response.data['message']}');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      throw Exception(e.response!.data['message'] ?? 'Unknown error');
    } else {
      throw Exception('Connection error');
    }
  }
}
