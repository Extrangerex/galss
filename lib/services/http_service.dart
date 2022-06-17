import 'package:dio/dio.dart';
import 'package:galss/main.dart';
import 'package:galss/services/auth_service.dart';

class HttpService {
  static const String apiUrl =
      "https://king-prawn-app-bfapo.ondigitalocean.app/api";
  static const String apiBaseUrl =
      "https://king-prawn-app-bfapo.ondigitalocean.app";

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
