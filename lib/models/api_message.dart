class ApiMessage {
  String? message;

  ApiMessage({this.message});

  ApiMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    return data;
  }
}
