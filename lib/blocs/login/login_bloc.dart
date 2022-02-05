import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/login/login_event.dart';
import 'package:galss/blocs/login/login_state.dart';
import 'package:galss/form_submission_status.dart';
import 'package:galss/main.dart';
import 'package:galss/services/auth_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginUsernameChanged>(
        (event, emit) => emit(state.copyWith(username: event.username)));
    on<LoginPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<LoginFormSubmitted>(_onLoginFormSubmitted);
  }

  Future<void> _onLoginFormSubmitted(
      LoginFormSubmitted event, Emitter<LoginState> emit) async {
    /**
     * perform login requests
     */
    emit(state.copyWith(formSubmissionStatus: const FormSubmittingStatus()));

    await locator<AuthService>()
        .repository
        .login(Map.from(
            {"emailAddress": state.username, "password": state.password}))
        .then((value) => emit(state.copyWith(
            formSubmissionStatus: FormSuccessStatus(payload: value.data))))
        .catchError((onError) {
      if (onError is DioError) {
        emit(state.copyWith(
            formSubmissionStatus: FormFailedStatus(
                exception: Exception(onError),
                status: onError.response!.statusCode!)));
      } else {
        emit(state.copyWith(
            formSubmissionStatus:
                FormFailedStatus(exception: Exception(onError))));
      }
    });
  }
}
