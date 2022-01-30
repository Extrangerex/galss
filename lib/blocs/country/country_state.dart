import 'package:galss/api_fetch_status.dart';
import 'package:galss/models/city.dart';
import 'package:galss/models/country.dart';

class CountryState {
  final List<Country> countries;
  final List<City> cities;
  final ApiFetchStatus apiFetchStatus;

  CountryState(
      {this.apiFetchStatus = const ApiFetchInitialStatus(),
      this.countries = const [],
      this.cities = const []});

  City findCityById(int cityId) {
    return cities.singleWhere((element) => element.id == cityId);
  }

  CountryState copyWith(
      {List<Country>? countries, List<City>? cities, ApiFetchStatus? apiFetchStatus}) {
    return CountryState(
        countries: countries ?? this.countries,
        cities: cities ?? this.cities,
        apiFetchStatus: apiFetchStatus ?? this.apiFetchStatus);
  }
}
