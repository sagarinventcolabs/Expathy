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
  bool? isDeleted;
  dynamic otp;
  int? percentage;
  String? language;
  String? type;
  String? profilePic;
  List<PsychologistLanguage>? psychologistLanguage;
  String? description;
  bool? isQuestionSubmit;
  bool? isSuicide;
  bool? isProfileCompleted;
  bool? isNotification;
  bool? isHaveTherapists;
  int? experience;
  String? loginType;
  List<AreaOfExperties>? areaOfExperties;
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

  PsychologistList(
      {this.isActive,
      this.isDeleted,
      this.otp,
      this.percentage,
      this.language,
      this.type,
      this.profilePic,
      this.psychologistLanguage,
      this.description,
      this.isQuestionSubmit,
      this.isSuicide,
      this.isProfileCompleted,
      this.isNotification,
      this.isHaveTherapists,
      this.experience,
      this.loginType,
      this.areaOfExperties,
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

  PsychologistList.fromJson(Map<String, dynamic> json) {
    isActive = json["is_active"];
    isDeleted = json["is_deleted"];
    otp = json["otp"];
    percentage = json["percentage"];
    language = json["language"];
    type = json["type"];
    profilePic = json["profilePic"];
    psychologistLanguage = json["psychologistLanguage"] == null
        ? null
        : (json["psychologistLanguage"] as List)
            .map((e) => PsychologistLanguage.fromJson(e))
            .toList();
    description = json["description"];
    isQuestionSubmit = json["isQuestionSubmit"];
    isSuicide = json["isSuicide"];
    isProfileCompleted = json["isProfileCompleted"];
    isNotification = json["is_notification"];
    isHaveTherapists = json["isHaveTherapists"];
    experience = json["experience"];
    loginType = json["loginType"];
    areaOfExperties = json["areaOfExperties"] == null
        ? null
        : (json["areaOfExperties"] as List)
            .map((e) => AreaOfExperties.fromJson(e))
            .toList();
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
    _data["is_active"] = isActive;
    _data["is_deleted"] = isDeleted;
    _data["otp"] = otp;
    _data["percentage"] = percentage;
    _data["language"] = language;
    _data["type"] = type;
    _data["profilePic"] = profilePic;
    if (psychologistLanguage != null) {
      _data["psychologistLanguage"] =
          psychologistLanguage?.map((e) => e.toJson()).toList();
    }
    _data["description"] = description;
    _data["isQuestionSubmit"] = isQuestionSubmit;
    _data["isSuicide"] = isSuicide;
    _data["isProfileCompleted"] = isProfileCompleted;
    _data["is_notification"] = isNotification;
    _data["isHaveTherapists"] = isHaveTherapists;
    _data["experience"] = experience;
    _data["loginType"] = loginType;
    if (areaOfExperties != null) {
      _data["areaOfExperties"] =
          areaOfExperties?.map((e) => e.toJson()).toList();
    }
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

class PsychologistType {
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? v;

  PsychologistType(
      {this.isActive,
      this.isDeleted,
      this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.v});

  PsychologistType.fromJson(Map<String, dynamic> json) {
    isActive = json["is_active"];
    isDeleted = json["is_deleted"];
    id = json["_id"];
    name = json["name"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["is_active"] = isActive;
    _data["is_deleted"] = isDeleted;
    _data["_id"] = id;
    _data["name"] = name;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class Education {
  String? id;
  String? university;
  String? graduationType;

  Education({this.id, this.university, this.graduationType});

  Education.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    university = json["university"];
    graduationType = json["graduationType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["university"] = university;
    _data["graduationType"] = graduationType;
    return _data;
  }
}

class AreaOfExperties {
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? v;

  AreaOfExperties(
      {this.isActive,
      this.isDeleted,
      this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.v});

  AreaOfExperties.fromJson(Map<String, dynamic> json) {
    isActive = json["is_active"];
    isDeleted = json["is_deleted"];
    id = json["_id"];
    name = json["name"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["is_active"] = isActive;
    _data["is_deleted"] = isDeleted;
    _data["_id"] = id;
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
