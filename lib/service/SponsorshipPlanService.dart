import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/core/api/api_resourses.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';

class Sponsorshipplanservice extends Baseservice {
  Future<bool> sponsorshipdonate(int id, int amount) async {
    final token = await SharedPrefs.getToken();
    try {
      responce = await dio.post("$baseURL/${ApiResourses.PlanSponsorship(id)}",
          data: {"amount": amount},
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (responce.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
