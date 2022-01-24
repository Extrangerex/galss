import 'package:galss/api_fetch_status.dart';

abstract class ChatRoomEvent {
  const ChatRoomEvent();
}

class ChatGetChatHistoryEvent extends ChatRoomEvent {
  final int roomId;

  const ChatGetChatHistoryEvent({required this.roomId});
}

class ChatSentGreetingEvent extends ChatRoomEvent {
  final int fromUserId;
  final int toUserId;
  final String greeting;

  const ChatSentGreetingEvent(
      {required this.fromUserId,
      required this.toUserId,
      required this.greeting});
}

class ChatMessageChanged extends ChatRoomEvent {
  final String message;

  const ChatMessageChanged({required this.message});
}

class ChatSentMessageEvent extends ChatRoomEvent {
  final String message;
  final int roomId;

  const ChatSentMessageEvent({required this.message, required this.roomId});
}
