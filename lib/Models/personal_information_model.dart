
class PersonalInformationModel {
  int? status;
  String? statusText;
  String? message;
  PersonalInfo? data;
  int? exeTime;

  PersonalInformationModel({this.status, this.statusText, this.message, this.data, this.exeTime});

  PersonalInformationModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusText = json["statusText"];
    message = json["message"];
    data = json["data"] == null ? null : PersonalInfo.fromJson(json["data"]);
    exeTime = json["exeTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["statusText"] = statusText;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    _data["exeTime"] = exeTime;
    return _data;
  }
}

class PersonalInfo {
  bool? isStatus;
  String? type;
  String? id;
  String? name;
  String? description;
  String? createdAt;
  String? modified;
  int? status;
  String? slug;
  String? descriptionAr;
  String? nameAr;
  String? updatedAt;

  PersonalInfo({this.isStatus, this.type, this.id, this.name, this.description, this.createdAt, this.modified, this.status, this.slug, this.descriptionAr, this.nameAr, this.updatedAt});

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    isStatus = json["is_status"];
    type = json["type"];
    id = json["_id"];
    name = json["name"];
    description = json["description"];
    createdAt = json["created_at"];
    modified = json["modified"];
    status = json["status"];
    slug = json["slug"];
    descriptionAr = json["description_ar"];
    nameAr = json["name_ar"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["is_status"] = isStatus;
    _data["type"] = type;
    _data["_id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["created_at"] = createdAt;
    _data["modified"] = modified;
    _data["status"] = status;
    _data["slug"] = slug;
    _data["description_ar"] = descriptionAr;
    _data["name_ar"] = nameAr;
    _data["updatedAt"] = updatedAt;
    return _data;
  }
}