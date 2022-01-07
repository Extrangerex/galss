class UserLatLng {
  int? userId;
  String? longitude;
  String? latitude;

  UserLatLng({this.userId, this.longitude, this.latitude});

  UserLatLng.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
