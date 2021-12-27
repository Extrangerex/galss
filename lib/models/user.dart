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
  UserLatLnt? lastLocation;
  bool? anonymous;
  String? profileStatus;
  Country? country;
  City? currentLocation;
  List<FCMUserDeviceToken>? deviceTokens;
}
