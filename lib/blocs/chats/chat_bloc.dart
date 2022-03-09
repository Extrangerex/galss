import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/chats/chat_event.dart';
import 'package:galss/blocs/chats/chat_state.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_chat.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/http_service.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<ChatGetChatsEvent>(_fetchChatHistory);
    on<ChatRoomsChanged>(
        (event, emit) => emit(state.copyWith(rooms: event.rooms)));
    on<ChatFetchStatusChanged>((event, emit) =>
        emit(state.copyWith(apiFetchStatus: event.apiFetchStatus)));
  }

  FutureOr<void> _fetchChatHistory(
      ChatGetChatsEvent event, Emitter<ChatState> emit) async {
    add(const ChatFetchStatusChanged(apiFetchStatus: ApiFetchingStatus()));

    final authData = await locator<AuthService>().authData;

    try {
      await locator<HttpService>()
          .http
          .get("${HttpService.apiUrl}/User/Chats/${authData.userId}")
          .then((value) => value.data)
          .then((value) => value as Iterable)
          .then((value) => value.map((e) => Chat.fromJson(e)).toList())
          .then((value) {
        add(const ChatFetchStatusChanged(
            apiFetchStatus: ApiFetchSucceededStatus()));
        add(ChatRoomsChanged(rooms: value));
      });
    } catch (e) {
      add(ChatFetchStatusChanged(
          apiFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }
}
