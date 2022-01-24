import 'package:galss/api_fetch_status.dart';
import 'package:galss/models/api_chat_message.dart';

class ChatRoomState {
  final List<ChatMessage> chatMessages;
  final ApiFetchStatus greetingFetchStatus;
  final ApiFetchStatus sentMessageFetchStatus;
  final ApiFetchStatus fetchChatHistoryStatus;
  final String? msgToSend;

  ChatRoomState(
      {this.chatMessages = const [],
      this.greetingFetchStatus = const ApiFetchInitialStatus(),
      this.sentMessageFetchStatus = const ApiFetchInitialStatus(),
      this.fetchChatHistoryStatus = const ApiFetchInitialStatus(),
      this.msgToSend});

  ChatRoomState copyWith(
          {List<ChatMessage>? chatMessages,
          ApiFetchStatus? greetingFetchStatus,
          ApiFetchStatus? sentMessageFetchStatus,
          ApiFetchStatus? fetchChatHistoryStatus,
          String? msgToSend}) =>
      ChatRoomState(
          chatMessages: chatMessages ?? this.chatMessages,
          greetingFetchStatus: greetingFetchStatus ?? this.greetingFetchStatus,
          sentMessageFetchStatus:
              sentMessageFetchStatus ?? this.sentMessageFetchStatus,
          fetchChatHistoryStatus:
              fetchChatHistoryStatus ?? this.fetchChatHistoryStatus,
      msgToSend: msgToSend ?? this.msgToSend);
}
