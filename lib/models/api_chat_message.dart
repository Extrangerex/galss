class ChatMessage {
  int? id;
  int? chatId;
  String? chatSubject;
  int? userId;
  String? userName;
  String? message;
  bool? read;
  String? readDate;
  String? creationDate;

  ChatMessage(
      {this.id,
        this.chatId,
        this.chatSubject,
        this.userId,
        this.userName,
        this.message,
        this.read,
        this.readDate,
        this.creationDate});

  ChatMessage.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    chatId = json['chatId'];
    chatSubject = json['chatSubject'];
    userId = json['userId'];
    userName = json['userName'];
    message = json['message'];
    read = json['read'];
    readDate = json['readDate'];
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['chatId'] = chatId;
    data['chatSubject'] = chatSubject;
    data['userId'] = userId;
    data['userName'] = userName;
    data['message'] = message;
    data['read'] = read;
    data['readDate'] = readDate;
    data['creationDate'] = creationDate;
    return data;
  }
}
