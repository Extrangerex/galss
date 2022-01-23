import 'package:galss/api_fetch_status.dart';
import 'package:galss/models/api_chat.dart';

class ChatState {
  final List<Chat> rooms;
  final ApiFetchStatus apiFetchStatus;

  const ChatState(
      {this.rooms = const [],
      this.apiFetchStatus = const ApiFetchInitialStatus()});

  ChatState copyWith({List<Chat>? rooms, ApiFetchStatus? apiFetchStatus}) {
    return ChatState(
        rooms: rooms ?? this.rooms,
        apiFetchStatus: apiFetchStatus ?? this.apiFetchStatus);
  }
}
