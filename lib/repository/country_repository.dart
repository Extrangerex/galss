import 'package:galss/main.dart';
import 'package:galss/models/country.dart';
import 'package:galss/services/http_service.dart';

class CountryRepository {
  final http = locator<HttpService>().http;

  Future<List<Country>> getCountry() async {
    return http.get('${HttpService.apiUrl}/country').then((value) {});
  }
}
