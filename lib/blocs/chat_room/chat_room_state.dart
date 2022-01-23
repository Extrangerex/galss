import 'package:galss/api_fetch_status.dart';
import 'package:galss/models/api_chat_message.dart';

class ChatRoomState {
  final List<ChatMessage> chatMessages;
  final ApiFetchStatus greetingFetchingStatus;
  final ApiFetchStatus sentMessageFetchingStatus;

  const ChatRoomState({this.chatMessages = const [
  ], this.greetingFetchingStatus = const ApiFetchInitialStatus(), this.sentMessageFetchingStatus = const ApiFetchInitialStatus()});


}