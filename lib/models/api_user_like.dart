import 'package:galss/models/user.dart';

class UserLike {
  int? id;
  User? user;
  String? creationDate;

  UserLike({this.id, this.user, this.creationDate});

  UserLike.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['creationDate'] = creationDate;
    return data;
  }
}
