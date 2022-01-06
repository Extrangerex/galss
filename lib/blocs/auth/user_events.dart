import 'package:galss/models/api_login.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserIsConnected extends UserEvent {
  final ApiLogin authLoginData;

  const UserIsConnected({required this.authLoginData});
}

class UserIsDisconnected extends UserEvent {}
