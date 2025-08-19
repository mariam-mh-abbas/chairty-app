import 'package:charity_project/blocs/volunteering_bloc/bloc/volunteering_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/models/benefits_model.dart';
import 'package:charity_project/models/reports_model.dart';
import 'package:charity_project/models/volunteering_model.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:dio/dio.dart';

class ReportService {
  final Dio dio = Dio();

  Future<List<ReportsModel>?> GetReports() async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) {
      return [];
    }

    final response = await dio.get(
      '$baseUrl/api/reports/getUserReports',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      if (response.data['data'] == null) return [];
      final List<dynamic> data = response.data['data'];
      return data.map((e) => ReportsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Reports');
    }
  }
}
