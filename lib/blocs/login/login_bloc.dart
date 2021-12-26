import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/login/login_event.dart';
import 'package:galss/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginUsernameChanged>((event, emit) => emit(state.copyWith(username: event.username)));
    on<LoginPasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    on<LoginFormSubmitted>(_onLoginFormSubmitted);
  }

  void _onLoginFormSubmitted(LoginFormSubmitted event, Emitter<LoginState> emit) {

  }


}
