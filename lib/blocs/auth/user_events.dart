import 'dart:io';

import 'package:galss/models/api_login.dart';
import 'package:galss/models/city.dart';
import 'package:galss/models/country.dart';
import 'package:galss/models/user.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserIsConnected extends UserEvent {
  final ApiLogin authLoginData;

  const UserIsConnected({required this.authLoginData});
}

class UserAnonymousChanged extends UserEvent {
  final bool anonymous;

  UserAnonymousChanged({required this.anonymous});
}

class UserIsDisconnected extends UserEvent {}

class FetchUserData extends UserEvent {
  final int? userId;

  const FetchUserData({this.userId});
}

class UserProfilePhotoChanged extends UserEvent {
  final XFile imageToUpload;

  const UserProfilePhotoChanged({required this.imageToUpload});
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

class UserCurrentLocationChanged extends UserEvent {
  final City city;
  final User user;

  const UserCurrentLocationChanged({required this.city, required this.user});
}

class FetchUserDataSucceed extends UserEvent {
  final User user;

  const FetchUserDataSucceed({required this.user});
}
