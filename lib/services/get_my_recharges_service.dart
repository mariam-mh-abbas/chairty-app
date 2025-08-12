import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/models/recharge_model.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RechargeService {
  final Dio _dio = Dio();

  Future<List<RechargeModel>?> getMyRecharge() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await SharedPrefs.getToken() ?? '';
    if (token == null || token.isEmpty) {
      return null;
    }

    final response = await _dio.get(
      '$baseUrl/api/user/getMyRecharges',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    if (response.statusCode == 200) {
      final List data = response.data['data'];
      return data.map((json) => RechargeModel.fromJson(json)).toList();
    } else {
      throw Exception('error');
    }
  }
}
