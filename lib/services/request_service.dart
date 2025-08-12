import 'package:charity_project/models/help_details_model.dart';
import 'package:charity_project/models/request_model.dart';
import 'package:charity_project/models/volunteer_details_model.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestService {
  final Dio _dio = Dio();

  Future<List<RequestModel>?> getAllUserHelpRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await SharedPrefs.getToken() ?? '';
    if (token == null || token.isEmpty) {
      return null;
    }

    final response = await _dio.get(
      '$baseUrl/api/beneficiary_request/getAllUserRequests',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    if (response.statusCode == 200) {
      final List data = response.data['data'];
      return data.map((json) => RequestModel.fromJson(json)).toList();
    } else {
      throw Exception('error');
    }
  }

  Future<List<RequestModel>?> getAllUserVolunteerRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await SharedPrefs.getToken() ?? '';

    if (token == null || token.isEmpty) {
      return null;
    }

    final response = await _dio.get(
      '$baseUrl/api/volunteer_request/getAllUserRequests',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    if (response.statusCode == 200) {
      final List data = response.data['data'];
      return data.map((json) => RequestModel.fromJson(json)).toList();
    } else {
      throw Exception('error');
    }
  }

  Future<VolunteerRequestDetailModel?> fetchRequestvolunteerDetails(
      int requestId) async {
    final token = await SharedPrefs.getToken();
    final response = await _dio.get(
      '$baseUrl/api/volunteer_request/getDetails/$requestId',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
    if (response.statusCode == 200) {
      final data = response.data['data'];
      if (data != null) {
        return VolunteerRequestDetailModel.fromJson(data);
      }
    }
    return null;
  }

  Future<HelpRequestDetailModel?> fetchRequestHelpDetails(int requestId) async {
    final token = await SharedPrefs.getToken();
    final response = await _dio.get(
      '$baseUrl/api/beneficiary_request/getDetails/$requestId',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
    if (response.statusCode == 200) {
      final data = response.data['data'];
      if (data != null) {
        return HelpRequestDetailModel.fromJson(data);
      }
    }
    return null;
  }
}
