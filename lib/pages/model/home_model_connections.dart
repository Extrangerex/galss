import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/chats/chat_bloc.dart';
import 'package:galss/blocs/chats/chat_event.dart';
import 'package:galss/blocs/chats/chat_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/pages/chat_room.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/images.dart';
import 'package:galss/shared/logo.dart';
import 'package:galss/theme/variables.dart';

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
      child: Theme(
        data: ThemeData.light(),
        child: Scaffold(
          appBar: AppBar(
            title: title(),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: _rooms(),
        ),
      ),
    );
  }

  Widget title() {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return Text(
        S.current.you_have_n_connections(state.rooms.length),
        style: TextStyle(color: primaryColor),
      );
    });
  }

  Widget _rooms() {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.rooms.length,
        itemBuilder: (context, index) {
          var e = state.rooms[index];
          var chatFriend = e.chatMembers
              ?.singleWhere((element) => element.isCreator == false);

          return ListTile(

            onTap: () {
              locator<NavigationService>().navigatorKey.currentState?.push(MaterialPageRoute(builder: (builder) => ChatRoom(chat: e)));
            },
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              child: CachedNetworkImage(
                imageUrl:
                    "${HttpService.apiBaseUrl}/${chatFriend?.user?.profilePhoto}",
                errorWidget: (context, url, error) =>
                    CircleAvatar(backgroundImage: profilePlaceholderImage),
              ),
            ),
            title: Text("${chatFriend?.user?.seeker?.fullName}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("${e.lastMessage}"), const Divider()],
            ),
            isThreeLine: true,
          );
        },
      );
    });
  }
}
