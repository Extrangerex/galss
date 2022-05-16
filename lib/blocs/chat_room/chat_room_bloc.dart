import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/chat_room/chat_room_event.dart';
import 'package:galss/blocs/chat_room/chat_room_state.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_chat_message.dart';
import 'package:galss/models/api_message.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/chat_service.dart';
import 'package:galss/services/http_service.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final ChatService chatService;

  ChatRoomBloc(this.chatService) : super(ChatRoomState()) {
    on<ChatGetChatHistoryEvent>(_fetchGetChatHistory);
    on<ChatMessageChanged>((event, emit) =>
        emit(state.copyWith(msgToSend: ChatMessage(message: event.message))));
    on<ChatSentMessageEvent>(_postChatMessage);

    on<ChatSentGreetingEvent>(_postChatGreeting);

    on<ChatJoinRoomEvent>(_joinRoom);
  }

  FutureOr<void> _joinRoom(
      ChatJoinRoomEvent event, Emitter<ChatRoomState> emit) async {
    final roomId = event.roomId;
    final userData = await locator<AuthService>().authData;

    chatService.join(
      ChatDto(
        chatId: roomId.toString(),
        fromUserId: userData.userId.toString(),
      ),
    );
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
              fetchChatHistoryStatus: const ApiFetchSucceededStatus(),
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
      return emit(state.copyWith(
          sentMessageFetchStatus: const ApiFetchSucceededStatus(),
          msgToSend: ChatMessage(
              message: event.message,
              chatId: event.roomId,
              userId: userData.userId)));
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
          .then((value) => emit(state.copyWith(
              greetingFetchStatus:
                  ApiFetchSucceededStatus(payload: value['chatId']))));
    } catch (e) {
      emit(state.copyWith(
          greetingFetchStatus: ApiFetchFailedStatus(exception: Exception(e))));
    }
  }
}
