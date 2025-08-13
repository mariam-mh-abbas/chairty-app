import 'package:charity_project/config/service_locater.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/core/api/api_resourses.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/service/GetCampaignDetailsService.dart';
import 'package:dio/dio.dart';

class Campaignsbycategoryidservice extends Baseservice{
  Future<List<dynamic>?> Getcampaignsbycategoryid(int id) async{
try {
  final savedLang = await SharedPrefs.getLanguage() ?? 'en';
  responce=await dio.get("$baseURL/${ApiResourses.CampaignByCategoryId(id)}",options: Options(
headers: {
      "Accept-Language": savedLang
    }
  ));
  if (responce.statusCode == 200 || responce.statusCode == 201) {
    return responce.data["data"];
  } else {
     throw Exception(responce.data["message"] );
   
  }
}  catch (e) {
  print(e);
  return null;
}
  }
}