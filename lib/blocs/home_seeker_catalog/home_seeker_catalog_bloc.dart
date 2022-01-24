import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/main.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/http_service.dart';

class HomeSeekerCatalogBloc
    extends Bloc<HomeSeekerCatalogEvent, HomeSeekerCatalogState> {
  HomeSeekerCatalogBloc() : super(const HomeSeekerCatalogState()) {
    on<HomeSeekerCatalogGetModelsEvent>(_fetchCatalogModels);
  }

  FutureOr<void> _fetchCatalogModels(HomeSeekerCatalogGetModelsEvent event,
      Emitter<HomeSeekerCatalogState> emit) async {
    emit(state.copyWith(fetchModelStatus: const ApiFetchingStatus()));

    try {
      await locator<HttpService>()
          .http
          .get("${HttpService.apiUrl}/User/Models")
          .then((value) => value.data)
          .then((value) => List.from(value))
          .then((value) => value.map((e) => User.fromJson(e)).toList())
          .then((value) => emit(state.copyWith(
              models: value,
              fetchModelStatus: const ApiFetchSuccededStatus())));
    } catch (e) {
      emit(state.copyWith(
          fetchModelStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }
}
