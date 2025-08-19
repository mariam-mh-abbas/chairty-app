import 'package:charity_project/config/service_locater.dart';
import 'package:dio/dio.dart';

abstract class Baseservice {
  Dio dio = Dio();
  late Response responce;
  String baseURL = "http://127.0.0.1:8000/api";
  // String token = "1|PD4S4LaPOUANCS4giTDMmMqyJ86LdNAFs31BHGVbe1364cdf";
}

String baseUrl = 'http://' + '127.0.0.1' + ':8000';
