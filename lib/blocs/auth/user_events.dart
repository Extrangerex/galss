import 'package:galss/models/api_login.dart';
import 'package:galss/models/user.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserIsConnected extends UserEvent {
  final ApiLogin authLoginData;

  const UserIsConnected({required this.authLoginData});
}

class UserIsDisconnected extends UserEvent {}

class FetchUserData extends UserEvent {
  final User user;

  const FetchUserData({required this.user});
}
