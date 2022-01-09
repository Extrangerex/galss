import 'package:galss/models/city.dart';
import 'package:galss/models/country.dart';

abstract class ModelEvent {
  const ModelEvent();
}

class ModelFullNameChanged {
  final String fullName;

  const ModelFullNameChanged({required this.fullName});
}

class ModelBornDateChanged {
  final DateTime dob;

  const ModelBornDateChanged({required this.dob});
}

class ModelCityChanged {
  final City city;

  const ModelCityChanged({required this.city});
}

class ModelCountryChanged {
  final Country country;

  const ModelCountryChanged({required this.country});
}
