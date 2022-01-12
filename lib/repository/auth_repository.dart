import 'package:dio/dio.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_message.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/http_service.dart';

class AuthRepository {
  final http = locator<HttpService>().http;

  AuthRepository();

  Future<Response<dynamic>> login(Map<String, dynamic> data) async {
    return http.post('${HttpService.apiUrl}/Login/SignIn', data: data);
  }

  Future<Response<dynamic>> signUp(Map<String, dynamic> data) async {
    return http.post('${HttpService.apiUrl}/Login/SignUp', data: data);
  }

  Future<User> getUserInfo(int userId) async {
    return http
        .get('${HttpService.apiUrl}/User/$userId')
        .then((value) => value.data)
        .then((value) => User.fromJson(value));
  }
}
