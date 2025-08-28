import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/core/api/api_resourses.dart';
import 'package:charity_project/model/GiftModel.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';

class Giftdonaitionservice extends Baseservice {
  Future<bool> GiftDonaition(Giftmodel gift) async {
    final token = await SharedPrefs.getToken() ?? '';
    try {
      responce = await dio.post("$baseURL/${ApiResourses.GiftDonaition}",
          data: gift.toMap(),
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (responce.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
