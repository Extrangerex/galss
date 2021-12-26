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

class LoginFormSubmitted extends LoginEvent {}
