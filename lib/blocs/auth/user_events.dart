import 'package:galss/models/api_login.dart';
import 'package:galss/models/city.dart';
import 'package:galss/models/country.dart';
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
  const FetchUserData();
}

class UserModelNameChanged extends UserEvent {
  final String name;

  const UserModelNameChanged({required this.name});
}

class UserProfileStatusChanged extends UserEvent {
  final String profileStatus;

  const UserProfileStatusChanged({required this.profileStatus});
}

class UserDateOfBirthChanged extends UserEvent {
  final DateTime dob;

  const UserDateOfBirthChanged({required this.dob});
}

class UserCountryChanged extends UserEvent {
  final Country country;

  const UserCountryChanged({required this.country});
}

class UserCityChanged extends UserEvent {
  final City city;

  const UserCityChanged({required this.city});
}

class FetchUserDataSucceded extends UserEvent {
  final User user;

  const FetchUserDataSucceded({required this.user});
}
