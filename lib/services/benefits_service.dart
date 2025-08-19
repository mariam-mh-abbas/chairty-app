import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/models/benefits_model.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:dio/dio.dart';

class BenefitsService {
  final Dio dio = Dio();

  Future<List<BenefitsModel>?> GetBenefits() async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) {
      return [];
    }

    final response = await dio.get(
      '$baseUrl/api/beneficiary/getAllBenefits',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      if (response.data == null) return [];
      final List data = response.data;
      return data.map((e) => BenefitsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load benefits');
    }
  }
}
