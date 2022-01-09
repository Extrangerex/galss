import 'dart:convert';

import 'package:galss/api_fetch_status.dart';
import 'package:galss/config/constants.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_login.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/shared_preferences.dart';

class UserState {
  final ApiLogin? authLoginData;
  final User? user;
  final ApiFetchStatus userDataFetchStatus;

  UserState(
      {this.authLoginData,
      this.user,
      this.userDataFetchStatus = const ApiFetchInitialStatus()});

  UserState copyWith(
          {ApiLogin? authLoginData,
          User? user,
          ApiFetchStatus? apiFetchStatus}) =>
      UserState(
          authLoginData: authLoginData ?? this.authLoginData,
          userDataFetchStatus: apiFetchStatus ?? userDataFetchStatus,
          user: user ?? this.user);
}
