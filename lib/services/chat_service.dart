import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  static const String kChatServiceUrl =
      'https://seal-app-n5qy9.ondigitalocean.app';

  BehaviorSubject<bool> connectionState = BehaviorSubject()..add(false);

  var io = IO.io(kChatServiceUrl, <String, dynamic>{
    'transports': ['websocket'],
    'forceNew': true
  });

  void onMessage(Function(dynamic) callback) {
    io.on('message', callback);
  }

  void onConnect(Function(dynamic) callback) {
    io.on('connect', callback);
  }

  void onStatus(Function(dynamic) callback) {
    io.on('status', callback);
  }

  void connect() {
    io.connect();
  }

  void Disconnect() {
    io.disconnect();
  }

  void emit(String event, Map<String, dynamic> data) {
    connectionState.add(io.connected);

    if (!io.connected) {
      io.connect();
    } else {
      io.emit(event, data);
      return;
    }

    io.onConnect((_) {
      io.emit(event, data);
    });
  }

  void join(ChatDto chatDto) {
    emit('join', chatDto.toJson());
  }

  void sendMessage(ChatDto chatDto) {
    emit('message', chatDto.toJson());
  }

  void status(ChatDto chatDto) {
    emit('status', chatDto.toJson());
  }
}

class ChatDto {
  String? chatId;
  String? fromUserId;
  String? message;

  ChatDto({this.chatId, this.fromUserId, this.message});

  ChatDto.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    fromUserId = json['fromUserId'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatId'] = chatId;
    data['fromUserId'] = fromUserId;
    data['message'] = message;
    return data;
  }
}
