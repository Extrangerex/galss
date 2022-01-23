import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/chats/chat_bloc.dart';
import 'package:galss/blocs/chats/chat_event.dart';
import 'package:galss/blocs/chats/chat_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/services/http_service.dart';

class HomeModelConnections extends StatefulWidget {
  const HomeModelConnections({Key? key}) : super(key: key);

  @override
  _HomeModelConnectionsState createState() => _HomeModelConnectionsState();
}

class _HomeModelConnectionsState extends State<HomeModelConnections> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (create) => ChatBloc()..add(const ChatGetChatsEvent()))
      ],
      child: Scaffold(
        appBar: AppBar(
          title: title(),
          backgroundColor: Colors.transparent,
        ),
        body:  _rooms(),
      ),
    );
  }

  Widget title() {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return Text(
        S.current.you_have_n_connections(state.rooms.length),
        style: TextStyle(color: Theme.of(context).primaryColor),
      );
    });
  }

  Widget _rooms() {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return ListView(
        children: [
          ...state.rooms.map((e) {
            var chatFriend = e.chatMembers?.singleWhere((element) => element.isCreator == false);

            return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage("${HttpService.apiBaseUrl}/${chatFriend?.user?.profilePhoto}"),
            ),
              title: Text("${chatFriend?.user?.seeker?.fullName}"),
              subtitle: Text("${e.lastMessage}"),

          );})
        ],
      );
    });
  }
}
