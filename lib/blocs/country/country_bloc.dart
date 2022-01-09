import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/country/country_event.dart';
import 'package:galss/blocs/country/country_state.dart';
import 'package:galss/main.dart';
import 'package:galss/services/country_service.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc(CountryState initialState) : super(initialState) {
    on<FetchListCountry>(_onFetchListCountry);
  }

  FutureOr<void> _onFetchListCountry(
      FetchListCountry event, Emitter<CountryState> emit) async {
    emit(state.copyWith(apiFetchStatus: const ApiFetchingStatus()));

    try {
      final countries =
          await locator<CountryService>().repository.getCountries();

      print(countries);

      emit(state.copyWith(
          countries: countries,
          apiFetchStatus: const ApiFetchSuccededStatus()));
    } catch (e) {
      emit(state.copyWith(
          apiFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }
}
