import 'package:flutter/cupertino.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/pages/model/home_model_landing.dart';

class HomeModelState {
  final ApiFetchStatus fetchStatus;

  HomeModelState({this.fetchStatus = const ApiFetchInitialStatus()});

  HomeModelState copyWith({ApiFetchStatus? apiFetchStatus}) =>
      HomeModelState(fetchStatus: apiFetchStatus ?? fetchStatus);
}
