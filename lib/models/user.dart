import 'package:galss/models/city.dart';
import 'package:galss/models/country.dart';
import 'package:galss/models/fcm_user_device_token.dart';
import 'package:galss/models/model.dart';
import 'package:galss/models/photo.dart';
import 'package:galss/models/seeker.dart';
import 'package:galss/models/user_lat_lng.dart';
import 'package:galss/models/user_type.dart';

class User {
  int? id;
  UserType? type;
  Model? model;
  Seeker? seeker;
  List<Photo>? photos;
  Photo? profilePhoto;
  UserLatLng? lastLocation;
  bool? anonymous;
  String? profileStatus;
  Country? country;
  City? currentLocation;
  List<DeviceToken>? deviceTokens;

  User(
      {this.id,
      this.type,
      this.model,
      this.seeker,
      this.photos,
      this.profilePhoto,
      this.lastLocation,
      this.anonymous,
      this.profileStatus,
      this.country,
      this.currentLocation,
      this.deviceTokens});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    seeker = json['seeker'] != null ? Seeker.fromJson(json['seeker']) : null;
    if (json['photos'] != null) {
      photos = <Photo>[];
      json['photos'].forEach((v) {
        photos!.add(Photo.fromJson(v));
      });
    }
    profilePhoto = json['profilePhoto'] != null
        ? Photo.fromJson(json['profilePhoto'])
        : null;
    lastLocation = json['lastLocation'] != null
        ? UserLatLng.fromJson(json['lastLocation'])
        : null;
    anonymous = json['anonymous'];
    profileStatus = json['profileStatus'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    currentLocation = json['currentLocation'] != null
        ? City.fromJson(json['currentLocation'])
        : null;
    if (json['deviceTokens'] != null) {
      deviceTokens = <DeviceToken>[];
      json['deviceTokens'].forEach((v) {
        deviceTokens!.add(DeviceToken.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    if (model != null) {
      data['model'] = model!.toJson();
    }
    if (seeker != null) {
      data['seeker'] = seeker!.toJson();
    }
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    if (profilePhoto != null) {
      data['profilePhoto'] = profilePhoto!.toJson();
    }
    if (lastLocation != null) {
      data['lastLocation'] = lastLocation!.toJson();
    }
    data['anonymous'] = anonymous;
    data['profileStatus'] = profileStatus;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (currentLocation != null) {
      data['currentLocation'] = currentLocation!.toJson();
    }
    if (deviceTokens != null) {
      data['deviceTokens'] = deviceTokens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
