import 'package:expathy/Models/pyschologist_list_model.dart';

class DashboardModel {
  int? status;
  String? statusText;
  Data? data;
  int? exeTime;

  DashboardModel({this.status, this.statusText, this.data, this.exeTime});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusText = json['statusText'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    exeTime = json['exeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusText'] = statusText;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['exeTime'] = exeTime;
    return data;
  }
}

class Data {
  String? sId;
  bool? isActive;
  bool? isDeleted;
  int? percentage;
  String? language;
  String? type;
  bool? isQuestionSubmit;
  bool? isSuicide;
  bool? isProfileCompleted;
  bool? isNotification;
  bool? isHaveTherapists;
  int? experience;
  String? loginType;
  String? email;
  String? password;
  String? userName;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;
  LanguageId? languageId;
  Therapists? therapists;
  int? age;
  int? completedFreeSession;
  int? completedPaidSession;
  String? endDate;
  int? freeSession;
  String? gossipSection;
  bool? isSubscription;
  int? noOfClick;
  int? paidSession;
  int? refferalCount;
  Subscription? subscription;
  String? address;
  int? latitude;
  int? longitude;
  List<Articles>? articles;

  Data({
    this.sId,
    this.isActive,
    this.isDeleted,
    this.percentage,
    this.language,
    this.type,
    this.isQuestionSubmit,
    this.isSuicide,
    this.isProfileCompleted,
    this.isNotification,
    this.isHaveTherapists,
    this.experience,
    this.loginType,
    this.email,
    this.password,
    this.userName,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.languageId,
    this.therapists,
    this.age,
    this.completedFreeSession,
    this.completedPaidSession,
    this.endDate,
    this.freeSession,
    this.gossipSection,
    this.isSubscription,
    this.noOfClick,
    this.paidSession,
    this.refferalCount,
    this.subscription,
    this.address,
    this.latitude,
    this.longitude,
    this.articles,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    percentage = json['percentage'];
    language = json['language'];
    type = json['type'];
    isQuestionSubmit = json['isQuestionSubmit'];
    isSuicide = json['isSuicide'];
    isProfileCompleted = json['isProfileCompleted'];
    isNotification = json['is_notification'];
    isHaveTherapists = json['isHaveTherapists'];
    experience = json['experience'];
    loginType = json['loginType'];
    email = json['email'];
    password = json['password'];
    userName = json['userName'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    languageId = json['languageId'] != null
        ? LanguageId.fromJson(json['languageId'])
        : null;
    therapists = json['therapists'] != null
        ? Therapists.fromJson(json['therapists'])
        : null;
    age = json['age'];
    completedFreeSession = json['completedFreeSession'];
    completedPaidSession = json['completedPaidSession'];
    endDate = json['endDate'];
    freeSession = json['freeSession'];
    gossipSection = json['gossipSection'];
    isSubscription = json['isSubscription'];
    noOfClick = json['noOfClick'];
    paidSession = json['paidSession'];
    refferalCount = json['refferalCount'];
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['is_active'] = isActive;
    data['is_deleted'] = isDeleted;
    data['percentage'] = percentage;
    data['language'] = language;
    data['type'] = type;
    data['isQuestionSubmit'] = isQuestionSubmit;
    data['isSuicide'] = isSuicide;
    data['isProfileCompleted'] = isProfileCompleted;
    data['is_notification'] = isNotification;
    data['isHaveTherapists'] = isHaveTherapists;
    data['experience'] = experience;
    data['loginType'] = loginType;
    data['email'] = email;
    data['password'] = password;
    data['userName'] = userName;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    if (languageId != null) {
      data['languageId'] = languageId!.toJson();
    }
    if (therapists != null) {
      data['therapists'] = therapists!.toJson();
    }
    data['age'] = age;
    data['completedFreeSession'] = completedFreeSession;
    data['completedPaidSession'] = completedPaidSession;
    data['endDate'] = endDate;
    data['freeSession'] = freeSession;
    data['gossipSection'] = gossipSection;
    data['isSubscription'] = isSubscription;
    data['noOfClick'] = noOfClick;
    data['paidSession'] = paidSession;
    data['refferalCount'] = refferalCount;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LanguageId {
  String? sId;
  bool? isStatus;
  bool? isDeleted;
  String? name;
  String? value;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LanguageId(
      {this.sId,
      this.isStatus,
      this.isDeleted,
      this.name,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.iV});

  LanguageId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isStatus = json['is_status'];
    isDeleted = json['is_deleted'];
    name = json['name'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['is_status'] = isStatus;
    data['is_deleted'] = isDeleted;
    data['name'] = name;
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Therapists {
  String? sId;
  bool? isActive;
  bool? isDeleted;
  Null? otp;
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
  String? email;
  String? password;
  String? userName;
  String? name;
  List<Education>? education;
  String? createdAt;
  String? updatedAt;
  int? iV;
  AreaOfExperties? psychologistType;

  Therapists(
      {this.sId,
      this.isActive,
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
      this.email,
      this.password,
      this.userName,
      this.name,
      this.education,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.psychologistType});

  Therapists.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    data['_id'] = sId;
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

class Subscription {
  String? sId;
  int? session;
  bool? isActive;
  int? price;
  String? type;
  String? dueDate;
  String? cancellationDate;
  String? language;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? totalPrice;

  Subscription(
      {this.sId,
      this.session,
      this.isActive,
      this.price,
      this.type,
      this.dueDate,
      this.cancellationDate,
      this.language,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.totalPrice});

  Subscription.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    session = json['session'];
    isActive = json['is_active'];
    price = json['price'];
    type = json['type'];
    dueDate = json['dueDate'];
    cancellationDate = json['cancellationDate'];
    language = json['language'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['session'] = session;
    data['is_active'] = isActive;
    data['price'] = price;
    data['type'] = type;
    data['dueDate'] = dueDate;
    data['cancellationDate'] = cancellationDate;
    data['language'] = language;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    data['totalPrice'] = totalPrice;
    return data;
  }
}

class Articles {
  List<Topic>? topic;
  bool? isStatus;
  bool? isDeleted;
  String? sId;
  String? content;
  String? image;
  String? title;
  LanguageId? language;
  String? psychologist;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Articles(
      {this.topic,
      this.isStatus,
      this.isDeleted,
      this.sId,
      this.content,
      this.image,
      this.title,
      this.language,
      this.psychologist,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Articles.fromJson(Map<String, dynamic> json) {
    if (json['topic'] != null) {
      topic = <Topic>[];
      json['topic'].forEach((v) {
        topic!.add(Topic.fromJson(v));
      });
    }
    isStatus = json['is_status'];
    isDeleted = json['is_deleted'];
    sId = json['_id'];
    content = json['content'];
    image = json['image'];
    title = json['title'];
    language =
        json['language'] != null ? LanguageId.fromJson(json['language']) : null;
    psychologist = json['psychologist'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topic != null) {
      data['topic'] = topic!.map((v) => v.toJson()).toList();
    }
    data['is_status'] = isStatus;
    data['is_deleted'] = isDeleted;
    data['_id'] = sId;
    data['content'] = content;
    data['image'] = image;
    data['title'] = title;
    if (language != null) {
      data['language'] = language!.toJson();
    }
    data['psychologist'] = psychologist;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Topic {
  bool? isStatus;
  bool? isDeleted;
  String? sId;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Topic(
      {this.isStatus,
      this.isDeleted,
      this.sId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Topic.fromJson(Map<String, dynamic> json) {
    isStatus = json['is_status'];
    isDeleted = json['is_deleted'];
    sId = json['_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_status'] = isStatus;
    data['is_deleted'] = isDeleted;
    data['_id'] = sId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
