import 'package:charity_project/models/gift_model.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiftService {
  final Dio _dio = Dio();

  Future<List<GiftModel>?> getAllGifts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await SharedPrefs.getToken() ?? '';
    if (token == null || token.isEmpty) {
      return null;
    }
    final response = await _dio.get(
      '$baseUrl/api/gift/getMyGiftDonations',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    if (response.statusCode == 200) {
      final List data = response.data['gifts'];
      return data.map((json) => GiftModel.fromJson(json)).toList();
    } else {
      throw Exception('error');
    }
  }
}
