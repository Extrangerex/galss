import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserIsConnected>((event, emit) =>
        emit(state.copyWith(authLoginData: event.authLoginData)));
    on<UserIsDisconnected>(
        (event, emit) => emit(state.copyWith(authLoginData: null)));
  }
}
