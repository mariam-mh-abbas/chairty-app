import 'package:charity_project/core/api/api_resourses.dart';
import 'package:charity_project/model/PeriodicallyDonaitionModel.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';

class Periodicallydonaitionservice extends Baseservice {
  Future<bool> periodicallydonaition (Periodicallydonaitionmodel periodicallydonaitionitem) async{
    try {
      responce = await dio.post("$baseURL/${ApiResourses.PeriodicallyDonaition}",data: periodicallydonaitionitem.toMap(),
      options: Options(
         headers: {
          "Authorization": "Bearer $token"
        }
        
      ));
      if (responce.statusCode == 200) {
        return true;
      }
      else{
         print('Response status: ${responce.statusCode}');
        print('Response body: ${responce.data}');
        return false;
      }
    } catch (e) {
      print('Dio Error: $e');
      return false;
    }
  }
}