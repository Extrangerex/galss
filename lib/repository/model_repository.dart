import 'package:galss/main.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/http_service.dart';

class ModelRepository {
  Future<List<User>> getRecentModels() async {
    try {
      return locator<HttpService>()
          .http
          .get("${HttpService.apiUrl}/User/Models/Recently")
          .then((value) => value.data)
          .then((value) => value as Iterable)
          .then((value) => value.map((e) => User.fromJson(e)).toList());
    } catch (e) {
      return [];
    }
  }

  Future<List<User>> getModels() async {
    try {
      return locator<HttpService>()
          .http
          .get("${HttpService.apiUrl}/User/Models")
          .then((value) => value.data)
          .then((value) => value as Iterable)
          .then((value) => value.map((e) => User.fromJson(e)).toList());
    } catch (e) {
      return [];
    }
  }
}
