import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/home_model/home_model_event.dart';
import 'package:galss/blocs/home_model/home_model_state.dart';
import 'package:galss/main.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/http_service.dart';

class HomeModelBloc extends Bloc<HomeModelEvent, HomeModelState> {
  HomeModelBloc() : super(HomeModelState()) {
    on<HomeModelFetchStatusChangedEvent>(
        (event, emit) => emit(state.copyWith(apiFetchStatus: event.newStatus)));

    on<HomeModelUploadImageEvent>(_uploadImageFile);
  }

  FutureOr<void> _uploadImageFile(
      HomeModelUploadImageEvent event, Emitter<HomeModelState> emit) async {
    final imageBytes = await event.imageFileToUpload.readAsBytes();
    final base64encodedImage = base64Encode(imageBytes);

    add(const HomeModelFetchStatusChangedEvent(newStatus: ApiFetchingStatus()));

    final userData = await locator<AuthService>().authData;

    await locator<HttpService>()
        .http
        .post('${HttpService.apiUrl}/User/Photos/${userData.userId}',
            data: {"data": base64encodedImage})
        .then((value) => emit(
            state.copyWith(apiFetchStatus: const ApiFetchSuccededStatus())))
        .onError((error, stackTrace) => emit(state.copyWith(
            apiFetchStatus:
                ApiFetchFailedStatus(exception: Exception(error)))));
  }
}
