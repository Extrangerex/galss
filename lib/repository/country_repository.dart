import 'package:galss/main.dart';
import 'package:galss/models/country.dart';
import 'package:galss/services/http_service.dart';

class CountryRepository {
  final http = locator<HttpService>().http;

  Future<List<Country>> getCountries() async {
    final response =
        await http.get<List<Country>>('${HttpService.apiUrl}/country');
    if (response.statusCode != 200) {
      throw Exception();
    }

    return response.data!;
  }
}
