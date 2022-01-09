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

    on<UserModelNameChanged>((event, emit) => emit(state.copyWith(
            user: state.user?.copyWith({
          "model": state.user!.model?.copyWith({"fullname": event.name})
        }))));

    on<UserDateOfBirthChanged>((event, emit) => emit(state.copyWith(
            user: state.user?.copyWith({
          "model": state.user?.model?.copyWith({"bornDate": event.dob})
        }))));
  }

  FutureOr<void> _fetchUserData(
      FetchUserData event, Emitter<UserState> emit) async {
    emit(state.copyWith(apiFetchStatus: const ApiFetchingStatus()));

    var userId = (await locator<AuthService>().authData).userId;

    await locator<AuthService>()
        .repository
        .getUserInfo(userId!)
        .then((value) => emit(state.copyWith(
            user: value, apiFetchStatus: const ApiFetchSuccededStatus())))
        .catchError((onError) => emit(state.copyWith(
            apiFetchStatus:
                ApiFetchFailedStatus(exception: Exception(onError)))));
  }
}
