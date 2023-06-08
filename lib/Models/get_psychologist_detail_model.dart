import 'package:expathy/Models/pyschologist_list_model.dart';

class GetPsychologistDetailApi {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  GetPsychologistDetailApi(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  GetPsychologistDetailApi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusText = json['statusText'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    exeTime = json['exeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusText'] = statusText;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['exeTime'] = exeTime;
    return data;
  }
}

class Data {
  int? age;
  String? gossipSection;
  bool? isActive;
  bool? isDeleted;
  dynamic otp;
  int? percentage;
  String? language;
  String? type;
  String? profilePic;
  List<PsychologistLanguage>? psychologistLanguage;
  String? description;
  int? noOfClick;
  dynamic loginTime;
  List<dynamic>? logoutTime;
  bool? isQuestionSubmit;
  bool? isSuicide;
  bool? isProfileCompleted;
  bool? isNotification;
  bool? isHaveTherapists;
  int? experience;
  String? loginType;
  List<AreaOfExperties>? areaOfExperties;
  List<String>? otherExperties;
  int? refferalCount;
  String? sId;
  String? email;
  String? password;
  String? userName;
  String? name;
  List<Education>? education;
  String? createdAt;
  String? updatedAt;
  int? iV;
  AreaOfExperties? psychologistType;

  Data(
      {this.age,
      this.gossipSection,
      this.isActive,
      this.isDeleted,
      this.otp,
      this.percentage,
      this.language,
      this.type,
      this.profilePic,
      this.psychologistLanguage,
      this.description,
      this.noOfClick,
      this.loginTime,
      this.logoutTime,
      this.isQuestionSubmit,
      this.isSuicide,
      this.isProfileCompleted,
      this.isNotification,
      this.isHaveTherapists,
      this.experience,
      this.loginType,
      this.areaOfExperties,
      this.otherExperties,
      this.refferalCount,
      this.sId,
      this.email,
      this.password,
      this.userName,
      this.name,
      this.education,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.psychologistType});

  Data.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    gossipSection = json['gossipSection'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    otp = json['otp'];
    percentage = json['percentage'];
    language = json['language'];
    type = json['type'];
    profilePic = json['profilePic'];
    if (json['psychologistLanguage'] != null) {
      psychologistLanguage = <PsychologistLanguage>[];
      json['psychologistLanguage'].forEach((v) {
        psychologistLanguage!.add(PsychologistLanguage.fromJson(v));
      });
    }
    description = json['description'];
    noOfClick = json['noOfClick'];
    loginTime = json['loginTime'];
    logoutTime = json["logoutTime"] == null
        ? []
        : List<dynamic>.from(json["logoutTime"]!.map((x) => x));
    isQuestionSubmit = json['isQuestionSubmit'];
    isSuicide = json['isSuicide'];
    isProfileCompleted = json['isProfileCompleted'];
    isNotification = json['is_notification'];
    isHaveTherapists = json['isHaveTherapists'];
    experience = json['experience'];
    loginType = json['loginType'];
    if (json['areaOfExperties'] != null) {
      areaOfExperties = <AreaOfExperties>[];
      json['areaOfExperties'].forEach((v) {
        areaOfExperties!.add(AreaOfExperties.fromJson(v));
      });
    }
    otherExperties = json['otherExperties'].cast<String>();
    refferalCount = json['refferalCount'];
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    userName = json['userName'];
    name = json['name'];
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(Education.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    psychologistType = json['psychologistType'] != null
        ? AreaOfExperties.fromJson(json['psychologistType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    data['gossipSection'] = gossipSection;
    data['is_active'] = isActive;
    data['is_deleted'] = isDeleted;
    data['otp'] = otp;
    data['percentage'] = percentage;
    data['language'] = language;
    data['type'] = type;
    data['profilePic'] = profilePic;
    if (psychologistLanguage != null) {
      data['psychologistLanguage'] =
          psychologistLanguage!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    data['noOfClick'] = noOfClick;
    data['loginTime'] = loginTime;
    if (logoutTime != null) {
      data['logoutTime'] = logoutTime!.map((v) => v.toJson()).toList();
    }
    data['isQuestionSubmit'] = isQuestionSubmit;
    data['isSuicide'] = isSuicide;
    data['isProfileCompleted'] = isProfileCompleted;
    data['is_notification'] = isNotification;
    data['isHaveTherapists'] = isHaveTherapists;
    data['experience'] = experience;
    data['loginType'] = loginType;
    if (areaOfExperties != null) {
      data['areaOfExperties'] =
          areaOfExperties!.map((v) => v.toJson()).toList();
    }
    data['otherExperties'] = otherExperties;
    data['refferalCount'] = refferalCount;
    data['_id'] = sId;
    data['email'] = email;
    data['password'] = password;
    data['userName'] = userName;
    data['name'] = name;
    if (education != null) {
      data['education'] = education!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    if (psychologistType != null) {
      data['psychologistType'] = psychologistType!.toJson();
    }
    return data;
  }
}
