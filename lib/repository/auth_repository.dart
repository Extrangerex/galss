import 'package:dio/dio.dart';
import 'package:galss/main.dart';
import 'package:galss/models/city.dart';
import 'package:galss/models/user.dart';
import 'package:galss/models/user_type.dart';
import 'package:galss/services/http_service.dart';

import '../models/photo.dart';

class AuthRepository {
  final http = locator<HttpService>().http;

  AuthRepository();

  Future<Response<dynamic>> login(Map<String, dynamic> data) async {
    return http.post('${HttpService.apiUrl}/Login/SignIn', data: data);
  }

  Future<Response<dynamic>> signUp(Map<String, dynamic> data) async {
    return http.post('${HttpService.apiUrl}/Login/SignUp', data: data);
  }

  Future<Response<dynamic>> postNewDeviceToken(
      int userId, String? deviceToken) async {
    return http.post("${HttpService.apiUrl}/User/DeviceToken/$userId",
        data: {"token": deviceToken});
  }

  Future<Response<dynamic>> toggleAnonymous(int userId,
      {bool isAnonymous = false}) async {
    return http.put(
        "${HttpService.apiUrl}/User/Anonymity/$userId/${isAnonymous ? 1 : 0}");
  }

  Future<Response<dynamic>> changeProfilePhoto(int userId, String photo) {
    return http.post("${HttpService.apiUrl}/User/Photos/$userId",
        data: {"data": photo});
  }

  Future<Response<dynamic>> changeProfileStatus(
      int userId, String profileStatus) {
    return http
        .put("${HttpService.apiUrl}/User/ProfileStatus/$userId/$profileStatus");
  }

  Future<Response<dynamic>> changeCurrentLocation(
      int userId, City targetCity, User user) {
    user.currentLocation = targetCity;

    return http.put("${HttpService.apiUrl}/User/$userId", data: user.toJson());
  }

  Future<Response<dynamic>> changeUsername(int userId, String name, User user) {
    if (user.type == UserType.seeker.index) {
      user.seeker?.fullName = name;
    }

    if (user.type == UserType.model.index) {
      user.model?.fullName = name;
    }

    return http.put("${HttpService.apiUrl}/User/$userId", data: user.toJson());
  }

  Future<Response<dynamic>> deletePhoto(int userId, Photo photo) async {
    print("${HttpService.apiUrl}/User/Photos/$userId/${photo.id}");

    return http.delete("${HttpService.apiUrl}/User/Photos/$userId/${photo.id}");
  }

  Future<User> getUserInfo(int userId) async {
    return http
        .get('${HttpService.apiUrl}/User/$userId')
        .then((value) => value.data)
        .then((value) => User.fromJson(value));
  }
}
