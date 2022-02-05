import 'package:galss/api_fetch_status.dart';
import 'package:galss/form_submission_status.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginUsernameChanged extends LoginEvent {
  final String? username;

  const LoginUsernameChanged({this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String? password;

  const LoginPasswordChanged({this.password});
}

class LoginFormStatusChanged extends LoginEvent {
  final FormSubmissionStatus formSubmissionStatus;

  const LoginFormStatusChanged({required this.formSubmissionStatus});
}

class LoginFormSubmitted extends LoginEvent {}
