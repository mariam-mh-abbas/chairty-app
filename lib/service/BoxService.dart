import 'package:charity_project/config/service_locater.dart';
import 'package:charity_project/core/api/api_resourses.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/model/BoxModel.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Boxservice extends Baseservice {
   Future<Map<String,dynamic>?> GetBox(String Type) async{
 
try {
    final savedLang = await SharedPrefs.getLanguage() ?? 'en';
  responce = await dio.get("$baseURL/${ApiResourses.Box(Type)}",options: Options(
    headers: {
      "Accept-Language": savedLang
    }
  ));
  if (responce.statusCode ==200) {
    return responce.data;
  }
  else{
    return null;
  }
} on Exception catch (e) {
 print(e);
 return null;
}

  }
}