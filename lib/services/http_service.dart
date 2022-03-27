import 'package:dio/dio.dart';
import 'package:galss/main.dart';
import 'package:galss/services/auth_service.dart';

class HttpService {
  static const String apiUrl = "http://165.227.82.134/api";
  static const String apiBaseUrl = "http://165.227.82.134";

  Dio get http {
    Dio _dio = Dio();
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      var auth = await locator<AuthService>().authData;

      if (auth.loginToken != null) {
        options.headers.addAll({"Authorization": auth.loginToken?.token});
      }

      handler.next(options);
    }));

    return _dio;
  }
}
