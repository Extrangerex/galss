import 'package:dio/dio.dart';

class HttpService {
  static const String apiUrl = "http://165.227.82.134/api";
  static const String apiBaseUrl = "http://165.227.82.134";

  Dio get http {
    Dio _dio = Dio();

    return _dio
      ..interceptors.add(InterceptorsWrapper(
        onError: (e, handler) {
          throw e.response?.data;
        },
      ));
  }
}
