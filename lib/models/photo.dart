class Photo {
  int? id;
  String? fileName;
  String? urlPath;
  String? creationDate;
  bool? deleted;
  String? updateDate;

  Photo(
      {this.id,
      this.fileName,
      this.urlPath,
      this.creationDate,
      this.deleted,
      this.updateDate});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['fileName'];
    urlPath = json['urlPath'];
    creationDate = json['creationDate'];
    deleted = json['deleted'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fileName'] = fileName;
    data['urlPath'] = urlPath;
    data['creationDate'] = creationDate;
    data['deleted'] = deleted;
    data['updateDate'] = updateDate;
    return data;
  }
}
