class UpdateProfileModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  UpdateProfileModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
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
  bool? isActive;
  dynamic otp;
  int? percentage;
  String? language;
  String? type;
  String? loginType;
  String? id;
  String? email;
  String? password;
  String? userName;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? languageId;

  Data(
      {this.isActive,
      this.otp,
      this.percentage,
      this.language,
      this.type,
      this.loginType,
      this.id,
      this.email,
      this.password,
      this.userName,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.languageId});

  Data.fromJson(Map<String, dynamic> json) {
    isActive = json["is_active"];
    otp = json["otp"];
    percentage = json["percentage"];
    language = json["language"];
    type = json["type"];
    loginType = json["loginType"];
    id = json["_id"];
    email = json["email"];
    password = json["password"];
    userName = json["userName"];
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
    _data["loginType"] = loginType;
    _data["_id"] = id;
    _data["email"] = email;
    _data["password"] = password;
    _data["userName"] = userName;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    _data["languageId"] = languageId;
    return _data;
  }
}
