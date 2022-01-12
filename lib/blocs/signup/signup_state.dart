import 'package:galss/form_submission_status.dart';
import 'package:galss/models/city.dart';
import 'package:galss/models/country.dart';
import 'package:galss/models/user_type.dart';

class SignUpState {
  final String? name;
  final String? email;
  final String? password;
  final UserType userType;
  final DateTime? dob;
  final City? city;
  final Country? country;
  final FormSubmissionStatus formState;
  final bool licenseTermsAccepted;

  toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "userType": userType.index,
      "city": city,
      "dob": dob.toString(),
      "country": country,
      "licenseTermsAccepted": licenseTermsAccepted,
    };
  }

  SignUpState(
      {this.name,
      this.email,
      this.password,
      required this.userType,
      this.dob,
      this.city,
      this.country,
      this.licenseTermsAccepted = false,
      this.formState = const InitialFormStatus()});

  SignUpState copyWith(
      {String? name,
      String? email,
      String? password,
      UserType? userType,
      City? city,
      Country? country,
      bool? licenseTermsAccepted,
      DateTime? dob,
      List<Country>? countries,
      FormSubmissionStatus? formState}) {
    return SignUpState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        userType: userType ?? this.userType,
        city: city ?? this.city,
        dob: dob ?? this.dob,
        country: country ?? this.country,
        licenseTermsAccepted: licenseTermsAccepted ?? this.licenseTermsAccepted,
        formState: formState ?? this.formState);
  }
}
