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
  final ApiFetchStatus actionFetchStatus;

  UserState(
      {this.authLoginData,
      this.user,
      this.actionFetchStatus = const ApiFetchInitialStatus(),
      this.userDataFetchStatus = const ApiFetchInitialStatus()});

  UserState copyWith(
          {ApiLogin? authLoginData,
          User? user,
          ApiFetchStatus? apiFetchStatus,
          ApiFetchStatus? actionFetchStatus}) =>
      UserState(
          authLoginData: authLoginData ?? this.authLoginData,
          userDataFetchStatus: apiFetchStatus ?? userDataFetchStatus,
          actionFetchStatus: actionFetchStatus ?? this.actionFetchStatus,
          user: user ?? this.user);
}
