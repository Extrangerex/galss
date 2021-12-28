import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/country/country_event.dart';
import 'package:galss/blocs/country/country_state.dart';
import 'package:galss/form_submission_status.dart';
import 'package:galss/models/city.dart';
import 'package:galss/models/country.dart';
import 'package:galss/models/user_type.dart';

class SignUpState {
  final String? name;
  final String? email;
  final String? password;
  final UserType? userType;
  final City? city;
  final Country? country;
  final FormSubmissionStatus formState;
  CountryBloc? countryBloc;

  SignUpState(
      {this.name,
      this.email,
      this.password,
      this.userType,
      this.city,
      this.country,
      this.formState = const InitialFormStatus()}) {
    countryBloc = CountryBloc(CountryState());

    countryBloc?.add(const FetchListCountry());
  }

  SignUpState copyWith(
      {String? name,
      String? email,
      String? password,
      UserType? userType,
      City? city,
      Country? country,
      FormSubmissionStatus? formState}) {
    return SignUpState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        userType: userType ?? this.userType,
        city: city ?? this.city,
        country: country ?? this.country,
        formState: formState ?? this.formState);
  }
}
