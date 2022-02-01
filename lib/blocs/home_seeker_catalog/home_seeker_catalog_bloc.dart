import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_user_favorite.dart';
import 'package:galss/models/api_user_like.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/http_service.dart';

class HomeSeekerCatalogBloc
    extends Bloc<HomeSeekerCatalogEvent, HomeSeekerCatalogState> {
  HomeSeekerCatalogBloc() : super(const HomeSeekerCatalogState()) {
    on<HomeSeekerCatalogGetModelsEvent>(_fetchCatalogModels);
    on<HomeSeekerGetFavoritesEvent>(_fetchFavoriteModels);
    on<HomeSeekerGetLikedModelsEvent>(_fetchLikeModels);
    on<HomeSeekerFavModelClicked>(_toggleRequestFavModel);
    on<HomeSeekerLikeModelClicked>(_toggleRequestLikeModel);
    on<HomeSeekerGetCloseMeEvent>(_fetchCloseMeModels);
    on<HomeSeekerSearchFieldChanged>(_searchModels);
    on<HomeSeekerGetRecentlyAddedModelsEvent>(_fetchRecentModels);
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

  FutureOr<void> _fetchRecentModels(HomeSeekerGetRecentlyAddedModelsEvent event,
      Emitter<HomeSeekerCatalogState> emit) async {
    emit(state.copyWith(fetchModelStatus: const ApiFetchingStatus()));

    try {
      await locator<HttpService>()
          .http
          .get("${HttpService.apiUrl}/User/Models/Recently")
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

  FutureOr<void> _toggleRequestFavModel(HomeSeekerFavModelClicked event,
      Emitter<HomeSeekerCatalogState> emit) async {
    emit(state.copyWith(requestToggleModelStatus: const ApiFetchingStatus()));

    final userAuth = await locator<AuthService>().authData;

    try {
      if (event.isFavorite) {
        await locator<HttpService>()
            .http
            .delete(
                '${HttpService.apiUrl}/User/Favorites/${userAuth.userId}/${event.model.id}')
            .then((value) => value.data)
            .then((value) => emit(state.copyWith(
                requestToggleModelStatus: const ApiFetchSuccededStatus())));
        return;
      }
      await locator<HttpService>()
          .http
          .post(
              '${HttpService.apiUrl}/User/Favorites/${userAuth.userId}/${event.model.id}')
          .then((value) => value.data)
          .then((value) => emit(state.copyWith(
              requestToggleModelStatus: const ApiFetchSuccededStatus())));
    } catch (e) {
      print(e);
      emit(state.copyWith(
          fetchModelStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _toggleRequestLikeModel(HomeSeekerLikeModelClicked event,
      Emitter<HomeSeekerCatalogState> emit) async {
    emit(state.copyWith(requestToggleModelStatus: const ApiFetchingStatus()));

    final userAuth = await locator<AuthService>().authData;

    try {
      if (event.isLiked) {
        await locator<HttpService>()
            .http
            .delete(
                '${HttpService.apiUrl}/User/Likes/${event.model.id}/${userAuth.userId}')
            .then((value) => value.data)
            .then((value) => emit(state.copyWith(
                requestToggleModelStatus: const ApiFetchSuccededStatus())));
        return;
      }
      await locator<HttpService>()
          .http
          .post(
              '${HttpService.apiUrl}/User/Likes/${event.model.id}/${userAuth.userId}')
          .then((value) => value.data)
          .then((value) => emit(state.copyWith(
              requestToggleModelStatus: const ApiFetchSuccededStatus())));
    } catch (e) {
      emit(state.copyWith(
          fetchModelStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _fetchCloseMeModels(HomeSeekerGetCloseMeEvent event,
      Emitter<HomeSeekerCatalogState> emit) async {
    emit(state.copyWith(fetchModelStatus: const ApiFetchingStatus()));

    try {
      final userData = await locator<AuthService>().authData;

      await locator<HttpService>()
          .http
          .get("${HttpService.apiUrl}/User/Models/Nearby/${userData.userId}")
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

  FutureOr<void> _fetchFavoriteModels(HomeSeekerGetFavoritesEvent event,
      Emitter<HomeSeekerCatalogState> emit) async {
    emit(state.copyWith(
        fetchModelStatus: const ApiFetchingStatus(),
        requestToggleModelStatus: const ApiFetchInitialStatus()));

    try {
      final userData = await locator<AuthService>().authData;

      await locator<HttpService>()
          .http
          .get("${HttpService.apiUrl}/User/Favorites/${userData.userId}")
          .then((value) => value.data)
          .then((value) => List.from(value))
          .then((value) => value.map((e) => UserFavorite.fromJson(e)).toList())
          .then((value) => emit(state.copyWith(
              favorites: value,
              fetchModelStatus: const ApiFetchSuccededStatus())));
    } catch (e) {
      emit(state.copyWith(
          fetchModelStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _fetchLikeModels(HomeSeekerGetLikedModelsEvent event,
      Emitter<HomeSeekerCatalogState> emit) async {
    emit(state.copyWith(
        fetchModelStatus: const ApiFetchingStatus(),
        requestToggleModelStatus: const ApiFetchInitialStatus()));

    try {
      final userData = await locator<AuthService>().authData;

      await locator<HttpService>()
          .http
          .get("${HttpService.apiUrl}/User/Likes/${userData.userId}")
          .then((value) => value.data)
          .then((value) => List.from(value))
          .then((value) => value.map((e) => UserLike.fromJson(e)).toList())
          .then((value) => emit(state.copyWith(
              likes: value, fetchModelStatus: const ApiFetchSuccededStatus())));
    } catch (e) {
      emit(state.copyWith(
          fetchModelStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _searchModels(HomeSeekerSearchFieldChanged event,
      Emitter<HomeSeekerCatalogState> emit) async {
    emit(state.copyWith(fetchModelStatus: const ApiFetchingStatus()));

    try {
      await locator<HttpService>()
          .http
          .get("${HttpService.apiUrl}/User/Models/${event.q}")
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
