import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/main.dart';
import 'package:galss/services/auth_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserIsConnected>((event, emit) =>
        emit(state.copyWith(authLoginData: event.authLoginData)));
    on<UserIsDisconnected>(
        (event, emit) => emit(state.copyWith(authLoginData: null)));
    on<FetchUserData>(_fetchUserData);
  }

  FutureOr<void> _fetchUserData(
      FetchUserData event, Emitter<UserState> emit) async {
    emit(state.copyWith(apiFetchStatus: const ApiFetchingStatus()));

    var userId = locator<AuthService>().authLogin?.userId;

    print(locator<AuthService>().authLogin);

    if (userId == null) return;

    await locator<AuthService>()
        .repository
        .getUserInfo(userId)
        .then((value) => emit(state.copyWith(
            user: value.data, apiFetchStatus: const ApiFetchSuccededStatus())))
        .catchError((onError) => emit(state.copyWith(
            apiFetchStatus: ApiFetchFailedStatus(exception: onError))));
  }
}
