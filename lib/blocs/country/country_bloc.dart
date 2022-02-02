import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/country/country_event.dart';
import 'package:galss/blocs/country/country_state.dart';
import 'package:galss/main.dart';
import 'package:galss/models/city.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/country_service.dart';
import 'package:galss/services/http_service.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(CountryState()) {
    on<FetchListCountry>(_onFetchListCountry);
    on<FetchListCities>(_onFetchListCities);
  }

  FutureOr<void> _onFetchListCountry(
      FetchListCountry event, Emitter<CountryState> emit) async {
    emit(state.copyWith(apiFetchStatus: const ApiFetchingStatus()));

    try {
      final countries =
          await locator<CountryService>().repository.getCountries();

      emit(state.copyWith(
          countries: countries,
          apiFetchStatus: const ApiFetchSuccededStatus()));
    } catch (e) {
      emit(state.copyWith(
          apiFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _onFetchListCities(
      FetchListCities event, Emitter<CountryState> emit) async {
    emit(state.copyWith(apiFetchStatus: const ApiFetchingStatus()));

    var countryId = event.countryId;

    try {
      await locator<HttpService>()
          .http
          .get("${HttpService.apiUrl}/City/Country/${event.countryId}")
          .then((value) => value.data)
          .then((value) => List.from(value))
          .then((value) => value.map((e) => City.fromJson(e)).toList())
          .then((value) => emit(state.copyWith(
              cities: value, apiFetchStatus: const ApiFetchSuccededStatus())));
    } catch (e) {
      emit(state.copyWith(
          apiFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }
}
