import 'package:galss/models/api_login.dart';

class UserState {
  final ApiLogin? authLoginData;
  bool isAuthenticated = false;

  UserState({this.authLoginData}) {
    isAuthenticated = authLoginData != null;
  }

  UserState copyWith({ApiLogin? authLoginData}) =>
      UserState(authLoginData: authLoginData ?? this.authLoginData);
}
