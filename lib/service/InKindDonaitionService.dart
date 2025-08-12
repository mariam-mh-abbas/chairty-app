import 'package:charity_project/core/api/api_resourses.dart';
import 'package:charity_project/model/InKindCategoryModel.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';

class Inkinddonaitionservice extends Baseservice {
  Future<bool> InKindDonaition (InKindCategorymodel inkinditem) async{
try {
  responce = await dio.post("$baseURL/${ApiResourses.InKindDonaition}",data: inkinditem.toMap(),options: Options(
    headers: {
      "Authorization": "Bearer $token"
    }
    
  ));
  if (responce.statusCode == 201 || responce.statusCode ==200) {
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