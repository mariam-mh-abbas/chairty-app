import 'package:charity_project/config/service_locater.dart';
import 'package:dio/dio.dart';

abstract class Baseservice {
  Dio dio = Dio();
  late Response responce;
  String baseURL = "$baseUrl/api";
}

// String baseUrl = 'http://localhost:8000';

String baseUrl = 'http://89.116.236.10:7050';

// String baseUrl = 'http://10.176.27.11:8000';

// String baseUrl = 'http://192.168.43.11:8000';
