import 'package:charity_project/model/VolunteerRequestModel.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/service/HelpRequestService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';
class Volunteerrequestservice extends Baseservice {
  Future<void>VolunteerRequestService(VolunteerRequestModel model)async{
try {
  Dio req =  Dio() ;
  Response res = await req.post("$baseURL/volunteer_request/add",data: model.toJson(),options: Options(
    headers: {"Authorization": "Bearer $token"}
  ))
  ;

  if (res.statusCode == 200 || res.statusCode == 201) {
        print("Request submitted successfully");
      } else {
        print("Error: ${res.statusCode} - ${res.statusMessage}");
      }
} on DioException catch (e) {
  print("Dio Error: ${e.message}");
}
}
}
