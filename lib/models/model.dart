// ignore_for_file: unnecessary_new

class Model {
  int? id;
  String? fullName;
  String? bornDate;
  int? city;
  int? status;
  String? verifiedDate;
  int? likesCount;

  Model(
      {this.id,
      this.fullName,
      this.bornDate,
      this.city,
      this.status,
      this.verifiedDate,
      this.likesCount});

  Model copyWith(Map<String, dynamic> json) => Model(
      id: id,
      fullName: json['fullName'] ?? fullName,
      bornDate: json['bornDate'] ?? bornDate,
      city: json['city'] ?? city,
      status: status,
      verifiedDate: verifiedDate,
      likesCount: likesCount);

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    bornDate = json['bornDate'];
    city = json['city'];
    status = json['status'];
    verifiedDate = json['verifiedDate'];
    likesCount = json['likesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fullName'] = fullName;
    data['bornDate'] = bornDate;
    data['city'] = city;
    data['status'] = status;
    data['verifiedDate'] = verifiedDate;
    data['likesCount'] = likesCount;
    return data;
  }
}
