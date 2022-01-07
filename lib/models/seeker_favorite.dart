import 'package:galss/models/model.dart';

class SeekerFavorites {
  int? id;
  Model? model;
  String? creationDate;

  SeekerFavorites({this.id, this.model, this.creationDate});

  SeekerFavorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (model != null) {
      data['model'] = model!.toJson();
    }
    data['creationDate'] = creationDate;
    return data;
  }
}
