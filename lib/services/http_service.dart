import 'package:dio/dio.dart';

class HttpService {
  static const String apiUrl = "http://165.227.82.134/api";
  static const String apiBaseUrl = "http://165.227.82.134";

  Dio? _dio;

  Dio get http {
    _dio ??= Dio();

    return _dio!;
  }
}
