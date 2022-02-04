import 'dart:async';
import 'dart:convert';

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

    on<UserAnonymousChanged>(toggleAnonymous);

    on<UserModelNameChanged>((event, emit) => emit(state.copyWith(
            user: state.user?.copyWith({
          "model": state.user!.model?.copyWith({"fullname": event.name})
        }))));

    on<UserDateOfBirthChanged>((event, emit) => emit(state.copyWith(
            user: state.user?.copyWith({
          "model": state.user?.model?.copyWith({"bornDate": event.dob})
        }))));

    on<UserProfilePhotoChanged>(_updateProfilePhoto);

    on<UserProfileStatusChanged>(_profileStatusChanged);

    on<UserCurrentLocationChanged>(_currentLocationChanged);

    on<UserNameChanged>(_userNameChanged);
  }

  FutureOr<void> _fetchUserData(
      FetchUserData event, Emitter<UserState> emit) async {
    emit(state.copyWith(
        apiFetchStatus: const ApiFetchingStatus(),
        actionFetchStatus: const ApiFetchInitialStatus()));

    var userId = event.userId;

    if (event.userId == null) {
      userId = (await locator<AuthService>().authData).userId;
    }

    await locator<AuthService>()
        .repository
        .getUserInfo(userId!)
        .then((value) => emit(state.copyWith(
            user: value, apiFetchStatus: const ApiFetchSuccededStatus())))
        .catchError((onError) => emit(state.copyWith(
            apiFetchStatus:
                ApiFetchFailedStatus(exception: Exception(onError)))));
  }

  FutureOr<void> toggleAnonymous(
      UserAnonymousChanged event, Emitter<UserState> emit) async {
    emit(state.copyWith(actionFetchStatus: const ApiFetchingStatus()));

    try {
      var userId = (await locator<AuthService>().authData).userId;

      await locator<AuthService>()
          .repository
          .toggleAnonymous(userId!, isAnonymous: event.anonymous)
          .then((value) => emit(state.copyWith(
              actionFetchStatus: const ApiFetchSuccededStatus())))
          .catchError((onError) => emit(state.copyWith(
              actionFetchStatus:
                  ApiFetchFailedStatus(exception: Exception(onError)))));
    } catch (e) {
      emit(state.copyWith(
          actionFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _updateProfilePhoto(
      UserProfilePhotoChanged event, Emitter<UserState> emit) async {
    emit(state.copyWith(actionFetchStatus: const ApiFetchingStatus()));

    try {
      var userId = (await locator<AuthService>().authData).userId;

      final imageBytes = await event.imageToUpload.readAsBytes();

      final b64EncodedImage = base64Encode(imageBytes);

      await locator<AuthService>()
          .repository
          .changeProfilePhoto(userId!, b64EncodedImage)
          .then((value) => value.data)
          .then((value) => emit(state.copyWith(
              actionFetchStatus: const ApiFetchSuccededStatus())))
          .catchError((onError) => emit(state.copyWith(
              actionFetchStatus:
                  ApiFetchFailedStatus(exception: Exception(onError)))));
    } catch (e) {
      emit(state.copyWith(
          actionFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _profileStatusChanged(
      UserProfileStatusChanged event, Emitter<UserState> emit) async {
    emit(state.copyWith(actionFetchStatus: const ApiFetchingStatus()));

    try {
      var userId = (await locator<AuthService>().authData).userId;

      await locator<AuthService>()
          .repository
          .changeProfileStatus(userId!, event.profileStatus)
          .then((value) => value.data)
          .then((value) => emit(state.copyWith(
              actionFetchStatus: const ApiFetchSuccededStatus())))
          .catchError((onError) => emit(state.copyWith(
              actionFetchStatus:
                  ApiFetchFailedStatus(exception: Exception(onError)))));
    } catch (e) {
      emit(state.copyWith(
          actionFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _currentLocationChanged(
      UserCurrentLocationChanged event, Emitter<UserState> emit) async {
    emit(state.copyWith(actionFetchStatus: const ApiFetchingStatus()));

    try {
      var userId = (await locator<AuthService>().authData).userId;

      await locator<AuthService>()
          .repository
          .changeCurrentLocation(userId!, event.city, event.user)
          .then((value) => value.data)
          .then((value) => emit(state.copyWith(
              actionFetchStatus: const ApiFetchSuccededStatus())))
          .catchError((onError) => emit(state.copyWith(
              actionFetchStatus:
                  ApiFetchFailedStatus(exception: Exception(onError)))));
    } catch (e) {
      emit(state.copyWith(
          actionFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _userNameChanged(
      UserNameChanged event, Emitter<UserState> emit) async {
    emit(state.copyWith(actionFetchStatus: const ApiFetchingStatus()));

    try {
      var userId = (await locator<AuthService>().authData).userId;

      await locator<AuthService>()
          .repository
          .changeUsername(userId!, event.name, event.user)
          .then((value) => value.data)
          .then((value) => emit(state.copyWith(
              actionFetchStatus: const ApiFetchSuccededStatus())))
          .catchError((onError) => emit(state.copyWith(
              actionFetchStatus:
                  ApiFetchFailedStatus(exception: Exception(onError)))));
    } catch (e) {
      emit(state.copyWith(
          actionFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }
}
