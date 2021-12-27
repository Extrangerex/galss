import 'package:galss/models/city.dart';
import 'package:galss/models/country.dart';
import 'package:galss/models/user_type.dart';

abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpUserTypeChanged extends SignUpEvent {
  final UserType type;

  const SignUpUserTypeChanged({required this.type});
}

class SignUpNameChanged extends SignUpEvent {
  final String name;

  const SignUpNameChanged({required this.name});
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  const SignUpEmailChanged({required this.email});
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged({required this.password});
}

class SignUpCountryChanged extends SignUpEvent {
  final Country country;

  const SignUpCountryChanged({required this.country});
}

class SignUpCityChanged extends SignUpEvent {
  final City city;

  const SignUpCityChanged({required this.city});
}
