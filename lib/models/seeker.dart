import 'package:galss/models/seeker_favorite.dart';

class Seeker {
  int? id;
  String? fullName;
  String? bornDate;
  int? city;
  List<SeekerFavorites>? seekerFavorites;

  Seeker(
      {this.id, this.fullName, this.bornDate, this.city, this.seekerFavorites});

  Seeker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    bornDate = json['bornDate'];
    city = json['city'];
    if (json['seekerFavorites'] != null) {
      seekerFavorites = <SeekerFavorites>[];
      json['seekerFavorites'].forEach((v) {
        seekerFavorites!.add(SeekerFavorites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fullName'] = fullName;
    data['bornDate'] = bornDate;
    data['city'] = city;
    if (seekerFavorites != null) {
      data['seekerFavorites'] =
          seekerFavorites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
