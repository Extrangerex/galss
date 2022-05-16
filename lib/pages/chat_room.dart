import 'dart:async';

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
import 'package:galss/generated/l10n.dart';
import 'package:galss/models/api_chat.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/chat_service.dart';
import 'package:galss/services/firebase_messaging_service.dart';
import 'package:galss/theme/variables.dart';

class ChatRoom extends StatefulWidget {
  final Chat chat;

  const ChatRoom({Key? key, required this.chat}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _msgTextEditingController =
      TextEditingController();
  late ChatRoomBloc _chatRoomBloc;
  final ScrollController _scrollController = ScrollController();
  final chatService = ChatService();

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
  void initState() {
    super.initState();
    _chatRoomBloc = ChatRoomBloc(chatService);

    _chatRoomBloc.chatService.onMessage((p0) {
      if (_chatRoomBloc.isClosed) {
        return;
      }

      _chatRoomBloc.add(ChatGetChatHistoryEvent(roomId: widget.chat.id!));
    });
  }

  @override
  void dispose() {
    _chatRoomBloc.chatService.Disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (create) => UserBloc()..add(const FetchUserData())),
          BlocProvider(
              create: (create) => _chatRoomBloc
                ..add(ChatJoinRoomEvent(roomId: widget.chat.id!))
                ..add(ChatGetChatHistoryEvent(roomId: widget.chat.id!)))
        ],
        child: Scaffold(
          appBar: AppBar(
            title: title(),
          ),
          body: Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Expanded(child: chat()),
                  bottomSheet(),
                ],
              )),
        ));
  }

  void chatScrollUp() async {
    await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(
            milliseconds:
                (_scrollController.position.maxScrollExtent / 2).round()),
        curve: Curves.easeOutCirc);
  }

  Widget bottomSheet() {
    return BlocListener<ChatRoomBloc, ChatRoomState>(
      listener: (context, state) {
        if (state.sentMessageFetchStatus is ApiFetchSucceededStatus) {
          context
              .read<ChatRoomBloc>()
              .add(ChatGetChatHistoryEvent(roomId: widget.chat.id!));
          _msgTextEditingController.text = "";

          chatService.sendMessage(ChatDto(
              chatId: state.msgToSend?.chatId.toString(),
              fromUserId: state.msgToSend?.userId.toString(),
              message: state.msgToSend?.message));

          context.read<ChatRoomBloc>().emit(state.copyWith(
              sentMessageFetchStatus: const ApiFetchInitialStatus()));
        }
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 16),
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
                        if (state.msgToSend?.message?.isEmpty ?? true) {
                          return;
                        }

                        context.read<ChatRoomBloc>().add(ChatSentMessageEvent(
                            message: state.msgToSend?.message ?? "",
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
        reverse: true,
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        itemCount: state.chatMessages.length,
        itemBuilder: (context, index) {
          var item =
              state.chatMessages[(state.chatMessages.length - 1) - index];
          var somebody = item.userId != context.read<UserBloc>().state.user?.id;

          if (somebody) {
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

  Widget title() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      User? getChatFriend() {
        return widget.chat.chatMembers
            ?.firstWhere((element) => element.user?.id != state.user?.id)
            .user;
      }

      return Text(S.current.you_talking_with_n("${getChatFriend()?.fullName}"));
    });
  }
}
