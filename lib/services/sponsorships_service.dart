import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/models/sponsorships_model.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:dio/dio.dart';

class SponsorshipsService {
  final Dio dio = Dio();

  Future<List<PlanModel>?> GetSponsorships() async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) {
      return null;
    }

    final response = await dio.get(
      '$baseUrl/api/plans/getAll/for/user',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((e) => PlanModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Sponsorships');
    }
  }

  Future<bool> deactivatePlan(int planId) async {
    final token = await SharedPrefs.getToken();
    final response = await dio.post(
      '$baseUrl/api/plans/deactivate/$planId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> reactivatePlan(int planId) async {
    final token = await SharedPrefs.getToken();
    final response = await dio.post(
      '$baseUrl/api/plans/reactivate/$planId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
