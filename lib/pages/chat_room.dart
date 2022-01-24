import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/chat_room/chat_room_bloc.dart';
import 'package:galss/blocs/chat_room/chat_room_event.dart';
import 'package:galss/blocs/chat_room/chat_room_state.dart';
import 'package:galss/blocs/chats/chat_bloc.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/models/api_chat.dart';
import 'package:galss/models/user.dart';
import 'package:galss/theme/variables.dart';

class ChatRoom extends StatefulWidget {
  final Chat chat;

  const ChatRoom({Key? key, required this.chat}): super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _msgTextEditingController =
      TextEditingController();

  BubbleStyle styleSomebody = BubbleStyle(
    nip: BubbleNip.leftCenter,
    color: primaryColor,
    borderWidth: 1,
    elevation: 4,
    padding: const BubbleEdges.all(8.0),
    margin: const BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );

  BubbleStyle styleMe = BubbleStyle(
    nip: BubbleNip.rightCenter,
    padding: const BubbleEdges.all(8.0),
    color: holoGreenDark,
    borderWidth: 1,
    elevation: 4,
    margin: const BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.topRight,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (create) => UserBloc()..add(const FetchUserData())),
          BlocProvider(
              create: (create) => ChatRoomBloc()
                ..add(ChatGetChatHistoryEvent(roomId: widget.chat.id!)))
        ],
        child: Scaffold(
            appBar: AppBar(
              title: title(),
            ),
            body: Container(margin: EdgeInsets.only(top: 8.0), child: chat()),
            bottomSheet: bottomSheet()));
  }

  Widget bottomSheet() {
    return BlocListener<ChatRoomBloc, ChatRoomState>(
      listener: (context, state) {
        if (state.sentMessageFetchStatus is ApiFetchSuccededStatus) {
          context.read<ChatRoomBloc>().add(ChatGetChatHistoryEvent(roomId: widget.chat.id!));
          _msgTextEditingController.text = "";
          context.read<ChatRoomBloc>().emit(state.copyWith(sentMessageFetchStatus: const ApiFetchInitialStatus()));
        }
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: Theme(
          data: ThemeData.light(),
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
                  builder: (context, state) => TextField(
                    controller: _msgTextEditingController,
                    onChanged: (value) => context
                        .read<ChatRoomBloc>()
                        .add(ChatMessageChanged(message: value)),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 16),
                        hintText: S.current.type_a_message_placeholder,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ),
              BlocBuilder<ChatRoomBloc, ChatRoomState>(
                  builder: (context, state) => IconButton(
                      onPressed: () {
                        context.read<ChatRoomBloc>().add(ChatSentMessageEvent(
                            message: state.msgToSend ?? "",
                            roomId: widget.chat.id!));

                      },
                      icon: const FaIcon(FontAwesomeIcons.paperPlane)))
            ],
          ),
        ),
      ),
    );
  }

  Widget chat() {
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(builder: (context, state) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.chatMessages.length,
        itemBuilder: (context, index) {
          var item = state.chatMessages[index];
          var isCreator = partner?.user?.id != item.userId;

          if (isCreator) {
            return ListTile(
              title: Bubble(
                style: styleSomebody,
                child: Text("${item.message}"),
              ),
            );
          }

          return ListTile(
            title: Bubble(
              style: styleMe,
              child: Text("${item.message}"),
            ),
          );
        },
      );
    });
  }

  ChatMembers? get partner {
    return widget.chat.chatMembers
        ?.singleWhere((element) => element.isCreator == false);
  }

  Widget title() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return Text(S.current.you_talking_with_n("${partner?.user?.fullName}"));
    });
  }
}
