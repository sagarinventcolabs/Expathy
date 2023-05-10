class QuestionsListModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  QuestionsListModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  QuestionsListModel.fromJson(Map<String, dynamic> json) {
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
  List<Question>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Question.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Question {
  bool? isStatus;
  bool? isDeleted;
  String? id;
  String? language;
  String? question;
  List<Options>? options;
  String? createdAt;
  String? updatedAt;
  int? v;

  Question(
      {this.isStatus,
      this.isDeleted,
      this.id,
      this.language,
      this.question,
      this.options,
      this.createdAt,
      this.updatedAt,
      this.v});

  Question.fromJson(Map<String, dynamic> json) {
    isStatus = json["is_status"];
    isDeleted = json["is_deleted"];
    id = json["_id"];
    language = json["language"];
    question = json["question"];
    options = json["options"] == null
        ? null
        : (json["options"] as List).map((e) => Options.fromJson(e)).toList();
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["is_status"] = isStatus;
    _data["is_deleted"] = isDeleted;
    _data["_id"] = id;
    _data["language"] = language;
    _data["question"] = question;
    if (options != null) {
      _data["options"] = options?.map((e) => e.toJson()).toList();
    }
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class Options {
  String? id;
  String? option;
  bool isSelected = false;

  Options({this.id, this.option, required this.isSelected});

  Options.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    option = json["option"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["option"] = option;
    return _data;
  }
}
