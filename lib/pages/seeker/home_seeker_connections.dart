import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/chats/chat_bloc.dart';
import 'package:galss/blocs/chats/chat_event.dart';
import 'package:galss/blocs/chats/chat_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/navigation_service.dart';

import '../../main.dart';
import '../chat_room.dart';

class HomeSeekerMyConnections extends StatefulWidget {
  const HomeSeekerMyConnections({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeSeekerMyConnectionsState();
}

class _HomeSeekerMyConnectionsState extends State<HomeSeekerMyConnections> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (create) => ChatBloc()..add(const ChatGetChatsEvent()))
      ],
      child: Theme(
        data: ThemeData.light(),
        child: Scaffold(
          appBar: AppBar(
            title: title(),
            elevation: 0,
            centerTitle: true,
            // backgroundColor: Colors.transparent,
          ),
          body: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ChatBloc>().add(const ChatGetChatsEvent());
                  },
                  child: _rooms());
            },
          ),
        ),
      ),
    );
  }

  Widget _rooms() {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return ListView.builder(
        // shrinkWrap: true,
        itemCount: state.rooms.length,
        itemBuilder: (context, index) {
          var e = state.rooms[index];
          var chatFriend = e.chatMembers
              ?.singleWhere((element) => element.isCreator == false);

          return Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: .25))),
            child: ListTile(
                onTap: () {
                  locator<NavigationService>().navigatorKey.currentState?.push(
                      MaterialPageRoute(
                          builder: (builder) => ChatRoom(chat: e)));
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.black12,
                  backgroundImage: CachedNetworkImageProvider(
                      "${HttpService.apiBaseUrl}/${chatFriend?.user?.profilePhoto?.urlPath}"),
                ),
                title: Text("${chatFriend?.user?.model?.fullName}"),
                subtitle: Text("${e.lastMessage}")),
          );
        },
      );
    });
  }

  Widget title() {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return Text(
        S.current.you_have_n_connections(state.rooms.length),
        // style: TextStyle(color: primaryColor),
      );
    });
  }
}
