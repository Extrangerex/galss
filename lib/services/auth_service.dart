import 'dart:convert';

import 'package:galss/config/constants.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_login.dart';
import 'package:galss/repository/auth_repository.dart';
import 'package:galss/services/shared_preferences.dart';

class AuthService {
  final repository = AuthRepository();

  Future<bool> get isAuthenticated async {
    return (await authData).userId != null;
  }

  Future<ApiLogin> get authData async {
    var jsonString =
        await locator<SharedPreferencesService>().getItem(SharedPrefs.authData);

    return ApiLogin.fromJson(jsonDecode(jsonString ?? "{}"));
  }
}
