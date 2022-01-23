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
      {required this.fromUserId, required this.toUserId, required this.greeting});
}


class ChatSentMessageEvent extends ChatRoomEvent {
  final int fromUserId;
  final String message;

  const ChatSentMessageEvent({required this.fromUserId, required this.message});
}

