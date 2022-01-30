abstract class CountryEvent {
  const CountryEvent();
}

class FetchListCountry extends CountryEvent {
  const FetchListCountry();
}

class FetchListCities extends CountryEvent {
  final int countryId;

  const FetchListCities({required this.countryId});
}