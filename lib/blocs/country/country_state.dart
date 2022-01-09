import 'package:galss/api_fetch_status.dart';
import 'package:galss/models/country.dart';

class CountryState {
  final List<Country> countries;
  final ApiFetchStatus apiFetchStatus;

  CountryState(
      {this.apiFetchStatus = const ApiFetchInitialStatus(),
      this.countries = const []});

  CountryState copyWith(
      {List<Country>? countries, ApiFetchStatus? apiFetchStatus}) {
    return CountryState(
        countries: countries ?? this.countries,
        apiFetchStatus: apiFetchStatus ?? this.apiFetchStatus);
  }
}
