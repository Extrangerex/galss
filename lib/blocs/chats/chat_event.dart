import 'package:galss/api_fetch_status.dart';
import 'package:galss/models/api_chat.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class ChatGetChatsEvent extends ChatEvent {
  const ChatGetChatsEvent();
}

class ChatRoomsChanged extends ChatEvent {
  final List<Chat> rooms;

  const ChatRoomsChanged({required this.rooms});
}

class ChatFetchStatusChanged  extends ChatEvent{
  final ApiFetchStatus apiFetchStatus;

  const ChatFetchStatusChanged({required this.apiFetchStatus});
}
