import 'package:charity_project/blocs/volunteering_bloc/bloc/volunteering_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/models/benefits_model.dart';
import 'package:charity_project/models/volunteering_model.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:dio/dio.dart';

class VolunteeringService {
  final Dio dio = Dio();

  Future<List<VolunteeringModel>?> GetVolunteering() async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) {
      return [];
    }

    final response = await dio.get(
      '$baseUrl/api/volunteer/getAll',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      if (response.data['campaigns'] == null) return [];
      final List<dynamic> data = response.data['campaigns'];
      return data.map((e) => VolunteeringModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load volunteering');
    }
  }
}
