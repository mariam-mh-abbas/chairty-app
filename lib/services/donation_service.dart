import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/models/in_kind_model.dart';
import 'package:charity_project/models/periodically_model.dart';
import 'package:charity_project/models/regular_model.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:dio/dio.dart';

class DonationService {
  final Dio dio = Dio();

  Future<List<RegularModel>?> GetRugularDonations() async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) {
      return [];
    }

    final response = await dio.get(
      '$baseUrl/api/user/getMyDonations',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      if (response.data['donations'] == null) return [];
      final List<dynamic> data = response.data['donations'];
      return data.map((e) => RegularModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Rugulars');
    }
  }

  Future<List<InKindModel>?> GetInKindsDonations() async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) {
      return [];
    }

    final response = await dio.get(
      '$baseUrl/api/inKinds/getAll/for/user',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((e) => InKindModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load in-kinds');
    }
  }

  Future<List<PeriodicallyModel>?> GetPeriodacllyDonations() async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) {
      return [];
    }

    final response = await dio.get(
      '$baseUrl/api/plans/getAll/recurring/for/user',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      if (response.data['data'] == null) return [];
      final List<dynamic> data = response.data['data'];
      return data.map((e) => PeriodicallyModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Periodically');
    }
  }

  Future<PeriodicallyModel?> deactivatePlan(int planId) async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) {
      return null;
    }

    final response = await dio.post(
      '$baseUrl/api/plans/deactive/recurring/$planId',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      final data = response.data['data'];
      return PeriodicallyModel.fromJson(data);
    } else {
      throw Exception('Failed to deactivate plan');
    }
  }

  Future<PeriodicallyModel?> reactivatePlan(int planId) async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) {
      return null;
    }

    final response = await dio.post(
      '$baseUrl/api/plans/reactive/recurring/$planId',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      final data = response.data['data'];
      return PeriodicallyModel.fromJson(data);
    } else {
      throw Exception('Failed to reactivate plan');
    }
  }
}
