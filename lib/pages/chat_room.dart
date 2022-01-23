

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/chats/chat_bloc.dart';
import 'package:galss/blocs/chats/chat_event.dart';

class ChatRoom extends StatefulWidget {
  final int roomId;

  ChatRoom({required this.roomId});

  @override
  State<StatefulWidget> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return MultiBlocProvider(providers: [
      BlocProvider(create: (create) => ChatBloc()..add( ChatGetChatHistoryEvent(roomId: widget.roomId)))
    ],
    child: Scaffold());
  }

}