import 'package:charity_project/config/service_locater.dart';
import 'package:charity_project/core/api/api_resourses.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';

class Getcampaigndetailsservice extends Baseservice {
 
 Future<Map<String,dynamic>?>Getcampaigndetails({required int id}) async{
 try {
 final savedLang = await SharedPrefs.getLanguage() ?? 'en';
  responce = await dio.get("$baseURL/${ApiResourses.campaignsDetails}/$id",options: Options(
    headers: {
      "Accept-Language": savedLang
    }
  ));
 if (responce.statusCode ==200 || responce.statusCode ==201) {
  return responce.data["data"];
 }
 else{
  return null;
 }
}  catch (e) {
      print(e);
      return null;
    }
 
 }
  
}