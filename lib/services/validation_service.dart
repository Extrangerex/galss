import 'package:galss/main.dart';
import 'package:galss/services/http_service.dart';

class ValidationService {
  static const String validationServiceUrl =
      "https://monkfish-app-s4wv3.ondigitalocean.app";

  Future<String> sendValidationCode(String? email) async {
    try {
      final response = await locator<HttpService>()
          .http
          .post("$validationServiceUrl/api/v1/validation/send/$email");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to send validation code');
      }
    } catch (e) {
      throw Exception('Failed to send validation code');
    }
  }
}
