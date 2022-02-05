import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/chat_room/chat_room_event.dart';
import 'package:galss/blocs/chat_room/chat_room_state.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_chat_message.dart';
import 'package:galss/models/api_message.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/http_service.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  ChatRoomBloc() : super(ChatRoomState()) {
    on<ChatGetChatHistoryEvent>(_fetchGetChatHistory);
    on<ChatMessageChanged>(
        (event, emit) => emit(state.copyWith(msgToSend: event.message)));
    on<ChatSentMessageEvent>(_postChatMessage);

    on<ChatSentGreetingEvent>(_postChatGreeting);
  }

  FutureOr<void> _fetchGetChatHistory(
      ChatGetChatHistoryEvent event, Emitter<ChatRoomState> emit) async {
    emit(state.copyWith(fetchChatHistoryStatus: const ApiFetchingStatus()));

    try {
      await locator<HttpService>()
          .http
          .get('${HttpService.apiUrl}/Chat/Messages/${event.roomId}')
          .then((value) => value.data)
          .then((value) => List.from(value))
          .then((value) => value.map((e) => ChatMessage.fromJson(e)).toList())
          .then((value) => emit(state.copyWith(
              fetchChatHistoryStatus: const ApiFetchSuccededStatus(),
              chatMessages: value)));
    } catch (e) {
      emit(state.copyWith(
          fetchChatHistoryStatus:
              ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _postChatMessage(
      ChatSentMessageEvent event, Emitter<ChatRoomState> emit) async {
    emit(state.copyWith(
        sentMessageFetchStatus: const ApiFetchingStatus(),
        greetingFetchStatus: const ApiFetchInitialStatus()));

    final userData = await locator<AuthService>().authData;

    try {
      await locator<HttpService>()
          .http
          .post("${HttpService.apiUrl}/Chat/Messages/${event.roomId}",
              data: {"fromUserId": userData.userId, "message": event.message})
          .then((value) => value.data)
          .then((value) => ApiMessage.fromJson(value))
          .then((value) => emit(state.copyWith(
              sentMessageFetchStatus: const ApiFetchSuccededStatus())));
    } catch (e) {
      emit(state.copyWith(
          sentMessageFetchStatus:
              ApiFetchFailedStatus(exception: Exception(e))));
    }
  }

  FutureOr<void> _postChatGreeting(
      ChatSentGreetingEvent event, Emitter<ChatRoomState> emit) async {
    emit(state.copyWith(greetingFetchStatus: const ApiFetchingStatus()));

    final userData = await locator<AuthService>().authData;

    try {
      await locator<HttpService>()
          .http
          .post("${HttpService.apiUrl}/Chat", data: {
            "fromUserId": userData.userId,
            "message": event.greeting,
            "toUserId": event.toUserId
          })
          .then((value) => value.data)
          .then((value) => ApiMessage.fromJson(value))
          .then((value) => emit(state.copyWith(
              greetingFetchStatus: const ApiFetchSuccededStatus())));
    } catch (e) {
      emit(state.copyWith(
          greetingFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }
}
