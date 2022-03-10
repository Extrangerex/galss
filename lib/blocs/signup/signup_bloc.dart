import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/signup/signup_event.dart';
import 'package:galss/blocs/signup/signup_state.dart';
import 'package:galss/form_submission_status.dart';
import 'package:galss/main.dart';
import 'package:galss/services/auth_service.dart';
import 'package:intl/intl.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  StreamSubscription? countryStreamSubscription;

  SignUpBloc(SignUpState initialState) : super(initialState) {
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

    on<SignUpFormSubmitted>(_onSignUpFormSubmitted);

    on<SignUpLicenseTermsAcceptedChanged>((event, emit) =>
        emit(state.copyWith(licenseTermsAccepted: event.licenseTermsAccepted)));

    on<SignUpPasswordConfirmationChanged>((event, emit) =>
        emit(state.copyWith(passwordConfirmation: event.password)));

    on<SignUpDateOfBirthChanged>(
        (event, emit) => emit(state.copyWith(dob: event.dob)));
  }

  FutureOr<void> _onSignUpFormSubmitted(
      SignUpFormSubmitted event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(formState: const FormSubmittingStatus()));
    var repository = locator<AuthService>().repository;

    try {
      var body = Map<String, dynamic>.from({
        "user": {
          "fullName": state.name,
          "type": state.userType.index,
          "bornDate": DateFormat("yyyy-MM-dd").format(state.dob!),
          "country": state.country?.id
        },
        "login": {"emailAddress": state.email, "password": state.password}
      });

      var response = await repository.signUp(body);

      print(response.statusCode);

      if (response.statusCode == 409) {
      } else if (response.statusCode == 200) {
        emit(state.copyWith(
            formState: FormSuccessStatus(payload: response.data)));
      } else if (response.statusCode == 400) {}
    } catch (e) {
      if (e is DioError) {
        emit(state.copyWith(
            formState: FormFailedStatus(
                exception: Exception(e), status: e.response!.statusCode!)));
        return;
      }
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
