// import 'package:charity_project/core/api/api_resourses.dart';
// import 'package:charity_project/service/BaseService.dart';
// import 'package:charity_project/view/homa_page.dart';
// import 'package:dio/dio.dart';

// class Oncepaymentservice extends Baseservice {
//   Future<bool>oncepaymentmethod(dynamic payedItem) async{
//     try {
//       responce = await dio.post("$baseURL/${ApiResourses.OncePayment}",data:payedItem,
//       options: Options(headers: {
//         "Authorization": "Bearer $token"
//       }));
//       if (responce.statusCode == 201) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

// }
// once_payment_service.dart
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/core/api/api_resourses.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';

class Oncepaymentservice extends Baseservice {
  Future<bool> oncepaymentmethod(Map<dynamic, dynamic> payedBody) async {
    final token = await SharedPrefs.getToken() ?? '';
    try {
      responce = await dio.post(
        "$baseURL/${ApiResourses.OncePayment}",
        data: payedBody,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (responce.statusCode == 201) {
        return true;
      } else {
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
