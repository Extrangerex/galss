import 'package:galss/form_submission_status.dart';

class LoginState {
  final String? username;
  final String? password;
  final FormSubmissionStatus formState;

  LoginState(
      {this.username,
      this.password,
      this.formState = const InitialFormStatus()});

  LoginState copyWith(
      {String? username,
      String? password,
      FormSubmissionStatus? formSubmissionStatus}) {
    return LoginState(
        username: username ?? this.username,
        password: this.password,
        formState: formSubmissionStatus ?? formState);
  }
}
