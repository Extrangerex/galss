import 'package:galss/form_submission_status.dart';
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

class SignUpPasswordConfirmationChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordConfirmationChanged({required this.password});
}

class SignUpCountryChanged extends SignUpEvent {
  final Country country;

  const SignUpCountryChanged({required this.country});
}

class SignUpCityChanged extends SignUpEvent {
  final City city;

  const SignUpCityChanged({required this.city});
}

class SignUpCountryListChanged extends SignUpEvent {
  final List<Country> countries;

  const SignUpCountryListChanged({required this.countries});
}

class SignUpDateOfBirthChanged extends SignUpEvent {
  final DateTime dob;

  const SignUpDateOfBirthChanged({required this.dob});
}

class SignUpLicenseTermsAcceptedChanged extends SignUpEvent {
  final bool licenseTermsAccepted;

  const SignUpLicenseTermsAcceptedChanged({required this.licenseTermsAccepted});
}

class SignUpFormSubmitted extends SignUpEvent {}

class SignUpFormStatusChanged extends SignUpEvent {
  final FormSubmissionStatus status;

  const SignUpFormStatusChanged({required this.status});
}
