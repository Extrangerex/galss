class ApiLogin {
  int? userId;
  int? userType;
  LoginToken? loginToken;
  bool? isFirstLogin;

  ApiLogin({this.userId, this.userType, this.loginToken, this.isFirstLogin});

  ApiLogin.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userType = json['userType'];
    loginToken = json['loginToken'] != null
        ? LoginToken.fromJson(json['loginToken'])
        : null;
    isFirstLogin = json['isFirstLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = userId;
    data['userType'] = userType;
    if (loginToken != null) {
      data['loginToken'] = loginToken!.toJson();
    }
    data['isFirstLogin'] = isFirstLogin;
    return data;
  }
}

class LoginToken {
  String? emailAddress;
  String? token;

  LoginToken({this.emailAddress, this.token});

  LoginToken.fromJson(Map<String, dynamic> json) {
    emailAddress = json['emailAddress'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['emailAddress'] = emailAddress;
    data['token'] = token;
    return data;
  }
}
