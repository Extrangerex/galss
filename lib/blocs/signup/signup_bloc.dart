import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/signup/signup_event.dart';
import 'package:galss/blocs/signup/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(SignUpState initialState) : super(initialState) {
    on<SignUpNameChanged>(
        (event, emit) => emit(state.copyWith(name: event.name)));

    on<SignUpEmailChanged>(
        (event, emit) => emit(state.copyWith(email: event.email)));

    on<SignUpCountryChanged>(
        (event, emit) => emit(state.copyWith(country: event.country)));
  }
}
