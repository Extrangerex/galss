import 'package:galss/models/api_login.dart';
import 'package:galss/repository/auth_repository.dart';

class AuthService {
  final repository = AuthRepository();

  ApiLogin? authLogin;

  setAuthData(ApiLogin authLogin) {
    this.authLogin = authLogin;
  }
}
