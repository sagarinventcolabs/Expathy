class PsychologistListModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  PsychologistListModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  PsychologistListModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusText = json["statusText"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    exeTime = json["exeTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["statusText"] = statusText;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    _data["exeTime"] = exeTime;
    return _data;
  }
}

class Data {
  List<PsychologistList>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List)
            .map((e) => PsychologistList.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class PsychologistList {
  bool? isActive;
  dynamic otp;
  int? percentage;
  String? language;
  String? type;
  List<PsychologistLanguage>? psychologistLanguage;
  String? description;
  bool? isQuestionSubmit;
  bool? isHaveTherapists;
  int? experience;
  String? loginType;
  String? id;
  String? email;
  String? password;
  String? userName;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? v;

  PsychologistList(
      {this.isActive,
      this.otp,
      this.percentage,
      this.language,
      this.type,
      this.psychologistLanguage,
      this.description,
      this.isQuestionSubmit,
      this.isHaveTherapists,
      this.experience,
      this.loginType,
      this.id,
      this.email,
      this.password,
      this.userName,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.v});

  PsychologistList.fromJson(Map<String, dynamic> json) {
    isActive = json["is_active"];
    otp = json["otp"];
    percentage = json["percentage"];
    language = json["language"];
    type = json["type"];
    psychologistLanguage = json["psychologistLanguage"] == null
        ? null
        : (json["psychologistLanguage"] as List)
            .map((e) => PsychologistLanguage.fromJson(e))
            .toList();
    description = json["description"];
    isQuestionSubmit = json["isQuestionSubmit"];
    isHaveTherapists = json["isHaveTherapists"];
    experience = json["experience"];
    loginType = json["loginType"];
    id = json["_id"];
    email = json["email"];
    password = json["password"];
    userName = json["userName"];
    name = json["name"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["is_active"] = isActive;
    _data["otp"] = otp;
    _data["percentage"] = percentage;
    _data["language"] = language;
    _data["type"] = type;
    if (psychologistLanguage != null) {
      _data["psychologistLanguage"] =
          psychologistLanguage?.map((e) => e.toJson()).toList();
    }
    _data["description"] = description;
    _data["isQuestionSubmit"] = isQuestionSubmit;
    _data["isHaveTherapists"] = isHaveTherapists;
    _data["experience"] = experience;
    _data["loginType"] = loginType;
    _data["_id"] = id;
    _data["email"] = email;
    _data["password"] = password;
    _data["userName"] = userName;
    _data["name"] = name;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class PsychologistLanguage {
  bool? isStatus;
  bool? isDeleted;
  String? id;
  String? name;
  String? value;
  String? createdAt;
  String? updatedAt;
  int? v;

  PsychologistLanguage(
      {this.isStatus,
      this.isDeleted,
      this.id,
      this.name,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.v});

  PsychologistLanguage.fromJson(Map<String, dynamic> json) {
    isStatus = json["is_status"];
    isDeleted = json["is_deleted"];
    id = json["_id"];
    name = json["name"];
    value = json["value"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["is_status"] = isStatus;
    _data["is_deleted"] = isDeleted;
    _data["_id"] = id;
    _data["name"] = name;
    _data["value"] = value;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
