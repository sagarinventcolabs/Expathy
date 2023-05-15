class AuthModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  AuthModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  AuthModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["token"] = token;
    return _data;
  }
}

class User {
  bool? isActive;
  dynamic otp;
  int? percentage;
  String? language;
  String? type;
  List<dynamic>? psychologistLanguage;
  dynamic description;
  bool? isQuestionSubmit;
  bool? isSuicide;
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
  String? languageId;

  User(
      {this.isActive,
      this.otp,
      this.percentage,
      this.language,
      this.type,
      this.psychologistLanguage,
      this.description,
      this.isQuestionSubmit,
      this.isSuicide,
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
      this.v,
      this.languageId});

  User.fromJson(Map<String, dynamic> json) {
    isActive = json["is_active"];
    otp = json["otp"];
    percentage = json["percentage"];
    language = json["language"];
    type = json["type"];
    psychologistLanguage = json["psychologistLanguage"] ?? [];
    description = json["description"];
    isQuestionSubmit = json["isQuestionSubmit"];
    isSuicide = json["isSuicide"];
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
    languageId = json["languageId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["is_active"] = isActive;
    _data["otp"] = otp;
    _data["percentage"] = percentage;
    _data["language"] = language;
    _data["type"] = type;
    if (psychologistLanguage != null) {
      _data["psychologistLanguage"] = psychologistLanguage;
    }
    _data["description"] = description;
    _data["isQuestionSubmit"] = isQuestionSubmit;
    _data["isSuicide"] = isSuicide;
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
    _data["languageId"] = languageId;
    return _data;
  }
}
