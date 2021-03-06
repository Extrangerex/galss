import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:galss/config/constants.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_login.dart';
import 'package:galss/models/api_message.dart';
import 'package:galss/repository/auth_repository.dart';
import 'package:galss/services/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final repository = AuthRepository();
  final user = BehaviorSubject<ApiLogin?>();

  Future<bool> get isAuthenticated async {
    return (await authData).userId != null;
  }

  Future<ApiMessage?> postNewDeviceToken(String? deviceToken,
      {ApiLogin? apiLogin}) async {
    final userData = apiLogin ?? await authData;

    if (userData.userId == null) {
      return null;
    }

    return ApiMessage.fromJson(
        (await repository.postNewDeviceToken(userData.userId!, deviceToken))
            .data);
  }

  Future<ApiLogin> get authData async {
    var jsonString =
        await locator<SharedPreferencesService>().getItem(SharedPrefs.authData);

    user.add(ApiLogin.fromJson(jsonDecode(jsonString ?? "{}")));

    return user.value!;
  }

  Future<bool> signOut() async {
    user.add(null);

    await postNewDeviceToken("");

    return (await locator<SharedPreferencesService>()
            .deleteItem(SharedPrefs.authData) ??
        false);
  }
}
