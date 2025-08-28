import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/models/benefits_model.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:dio/dio.dart';

class BenefitsService {
  final Dio dio = Dio();

  Future<List<BenefitsModel>?> GetBenefits() async {
    final token = await SharedPrefs.getToken();
    if (token == null || token.isEmpty) {
      return [];
    }

    final response = await dio.get(
      '$baseUrl/api/beneficiary/getAllBenefits',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      if (data == null || data is! List) return [];
      return data.map((e) => BenefitsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load benefits');
    }
  }
}


// import 'package:charity_project/config/shared_prefs.dart';
// import 'package:charity_project/models/benefits_model.dart';
// import 'package:charity_project/service/BaseService.dart';
// import 'package:dio/dio.dart';

// class BenefitsService {
//   final Dio dio = Dio();

//   Future<List<BenefitsModel>> GetBenefits() async {
//     final token = await SharedPrefs.getToken();
//     if (token == null || token.isEmpty) {
//       return [];
//     }

//     try {
//       final response = await dio.get(
//         '$baseUrl/api/beneficiary/getAllBenefits',
//         options: Options(headers: {
//           'Authorization': 'Bearer $token',
//         }),
//       );

//       // إذا response.data قائمة، حولها لموديل
//       if (response.data != null && response.data is List) {
//         final List data = response.data;
//         return data.map((e) => BenefitsModel.fromJson(e)).toList();
//       }

//       // أي response غير متوقع، رجع قائمة فاضية
//       return [];
//     } on DioException catch (e) {
//       // إذا الـ API رجع 404 أو أي status آخر، اعتبرها بدون بيانات
//       if (e.response?.statusCode == 404) {
//         return [];
//       }
//       // أي خطأ ثاني، كرر throw
//       throw Exception('Failed to load benefits: ${e.message}');
//     } catch (e) {
//       // أي خطأ عام، رجع قائمة فاضية
//       return [];
//     }
//   }
// }
