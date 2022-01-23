import 'package:galss/models/user.dart';

class Chat {
  int? id;
  String? subject;
  int? status;
  List<ChatMembers>? chatMembers;
  String? creationDate;
  String? updateDate;
  String? lastMessage;

  Chat(
      {this.id,
      this.subject,
      this.status,
      this.chatMembers,
      this.creationDate,
      this.updateDate,
      this.lastMessage});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    status = json['status'];
    if (json['chatMembers'] != null) {
      chatMembers = <ChatMembers>[];
      json['chatMembers'].forEach((v) {
        chatMembers!.add( ChatMembers.fromJson(v));
      });
    }
    creationDate = json['creationDate'];
    updateDate = json['updateDate'];
    lastMessage = json['lastMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['subject'] = subject;
    data['status'] = status;
    if (chatMembers != null) {
      data['chatMembers'] = chatMembers!.map((v) => v.toJson()).toList();
    }
    data['creationDate'] = creationDate;
    data['updateDate'] = updateDate;
    data['lastMessage'] = lastMessage;
    return data;
  }
}

class ChatMembers {
  int? id;
  int? chatId;
  User? user;
  bool? isCreator;

  ChatMembers({this.id, this.chatId, this.user, this.isCreator});

  ChatMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chatId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    isCreator = json['isCreator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['chatId'] = chatId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['isCreator'] = isCreator;
    return data;
  }
}
