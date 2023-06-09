import 'package:expathy/Models/pyschologist_list_model.dart';
import 'get_psychologist_detail_model.dart';

class GetProfileModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  GetProfileModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? age;
  bool? isActive;
  bool? isDeleted;
  dynamic otp;
  int? percentage;
  String? language;
  String? type;
  String? description;
  bool? isQuestionSubmit;
  bool? isSuicide;
  bool? isProfileCompleted;
  bool? isNotification;
  bool? isHaveTherapists;
  int? experience;
  String? loginType;
  List<String>? otherExperties;
  String? id;
  String? email;
  String? password;
  String? userName;
  String? name;
  List<Education>? education;
  String? createdAt;
  String? updatedAt;
  int? v;
  PsychologistType? psychologistType;
  String? profilePic;

  Data(
      {this.isActive,
      this.age,
      this.isDeleted,
      this.profilePic,
      this.otp,
      this.percentage,
      this.language,
      this.type,
      this.description,
      this.isQuestionSubmit,
      this.isSuicide,
      this.isProfileCompleted,
      this.isNotification,
      this.isHaveTherapists,
      this.experience,
      this.loginType,
      this.otherExperties,
      this.id,
      this.email,
      this.password,
      this.userName,
      this.name,
      this.education,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.psychologistType});

  Data.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    isActive = json["is_active"];
    isDeleted = json["is_deleted"];
    otp = json["otp"];
    percentage = json["percentage"];
    language = json["language"];
    type = json["type"];
    profilePic = json["profilePic"];
    description = json["description"];
    isQuestionSubmit = json["isQuestionSubmit"];
    isSuicide = json["isSuicide"];
    isProfileCompleted = json["isProfileCompleted"];
    isNotification = json["is_notification"];
    isHaveTherapists = json["isHaveTherapists"];
    experience = json["experience"];
    loginType = json["loginType"];
    otherExperties = json["otherExperties"] == null
        ? null
        : List<String>.from(json["otherExperties"]);
    id = json["_id"];
    email = json["email"];
    password = json["password"];
    userName = json["userName"];
    name = json["name"];
    education = json["education"] == null
        ? null
        : (json["education"] as List)
            .map((e) => Education.fromJson(e))
            .toList();
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
    psychologistType = json["psychologistType"] == null
        ? null
        : PsychologistType.fromJson(json["psychologistType"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data['age'] = age;
    _data["is_active"] = isActive;
    _data["is_deleted"] = isDeleted;
    _data["otp"] = otp;
    _data["percentage"] = percentage;
    _data["profilePic"] = profilePic;
    _data["language"] = language;
    _data["type"] = type;

    _data["description"] = description;
    _data["isQuestionSubmit"] = isQuestionSubmit;
    _data["isSuicide"] = isSuicide;
    _data["isProfileCompleted"] = isProfileCompleted;
    _data["is_notification"] = isNotification;
    _data["isHaveTherapists"] = isHaveTherapists;
    _data["experience"] = experience;
    _data["loginType"] = loginType;

    if (otherExperties != null) {
      _data["otherExperties"] = otherExperties;
    }
    _data["_id"] = id;
    _data["email"] = email;
    _data["password"] = password;
    _data["userName"] = userName;
    _data["name"] = name;
    if (education != null) {
      _data["education"] = education?.map((e) => e.toJson()).toList();
    }
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    if (psychologistType != null) {
      _data["psychologistType"] = psychologistType?.toJson();
    }
    return _data;
  }
}
