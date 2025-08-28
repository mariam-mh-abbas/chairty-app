import 'package:charity_project/config/service_locater.dart';
import 'package:dio/dio.dart';

abstract class Baseservice {
  Dio dio = Dio();
  late Response responce;
  String baseURL = "http://10.221.177.11:8000/api";
}

String baseUrl = 'http://10.221.177.11:8000';
