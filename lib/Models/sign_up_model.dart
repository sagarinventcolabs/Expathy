class AuthModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;

  AuthModel({this.status, this.statusText, this.message, this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusText = json["statusText"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["statusText"] = statusText;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
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
  String? ids;
  String? email;
  String? password;
  String? userName;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? id;

  User(
      {this.ids,
      this.email,
      this.password,
      this.userName,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    email = json["email"];
    password = json["password"];
    userName = json["userName"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
    ids = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["email"] = email;
    _data["password"] = password;
    _data["userName"] = userName;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    _data["id"] = ids;
    return _data;
  }
}
