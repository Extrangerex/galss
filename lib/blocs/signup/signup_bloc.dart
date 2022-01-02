import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/signup/signup_event.dart';
import 'package:galss/blocs/signup/signup_state.dart';
import 'package:galss/form_submission_status.dart';
import 'package:galss/main.dart';
import 'package:galss/models/user_type.dart';
import 'package:galss/services/auth_service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final CountryBloc countryBloc;

  StreamSubscription? countryStreamSubscription;

  SignUpBloc(SignUpState initialState, {required this.countryBloc})
      : super(initialState) {
    on<SignUpNameChanged>(
        (event, emit) => emit(state.copyWith(name: event.name)));

    on<SignUpEmailChanged>(
        (event, emit) => emit(state.copyWith(email: event.email)));

    on<SignUpCountryChanged>(
        (event, emit) => emit(state.copyWith(country: event.country)));

    on<SignUpPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    on<SignUpCityChanged>(
        (event, emit) => emit(state.copyWith(city: event.city)));

    on<SignUpUserTypeChanged>(
        (event, emit) => emit(state.copyWith(userType: event.type)));

    on<SignUpCountryListChanged>(
        (event, emit) => emit(state.copyWith(countries: event.countries)));

    on<SignUpFormSubmitted>(_onSignUpFormSubmitted);

    on<SignUpLicenseTermsAcceptedChanged>((event, emit) =>
        emit(state.copyWith(licenseTermsAccepted: event.licenseTermsAccepted)));

    on<SignUpDateOfBirthChanged>(
        (event, emit) => state.copyWith(dob: event.dob));

    countryStreamSubscription = countryBloc.stream.listen((event) {
      if (event.apiFetchStatus is! ApiFetchSuccededStatus) {
        return;
      }
      add(SignUpCountryListChanged(countries: event.countries!));
    });
  }

  FutureOr<void> _onSignUpFormSubmitted(
      SignUpFormSubmitted event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(formState: const FormSubmittingStatus()));
    var repository = locator<AuthService>().repository;

    try {
      var body = Map<String, dynamic>.from({
        "user": {
          "fullName": state.name,
          "type": UserType.seeker,
          "bornDate": state.dob,
          "country": state.country!.id
        },
        "login": {"emailAddress": state.email, "password": state.password}
      });

      var response = await repository.signUp(body);

      if (response.statusCode == 409) {
      } else if (response.statusCode == 200) {
      } else if (response.statusCode == 400) {}
    } catch (e) {
      emit(
          state.copyWith(formState: FormFailedStatus(exception: Exception(e))));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    countryStreamSubscription?.cancel();
    return super.close();
  }
}
