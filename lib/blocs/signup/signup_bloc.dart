import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/signup/signup_event.dart';
import 'package:galss/blocs/signup/signup_state.dart';
import 'package:galss/form_submission_status.dart';

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

    try {} catch (e) {
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
